defmodule Mix.Tasks.SendMessages do
  use Mix.Task

  import Mix.Ecto

  @shortdoc "Send messages to all users"

  def run(_args) do
    ensure_started(VkBots.Repo, [])
    Application.ensure_all_started(:timex)
    Application.ensure_all_started(:ecto)

    HTTPotion.start

    users = VkBots.Repo.all(VkBots.User)
    for user <- users, do: get_groups(user)
  end

  defp get_groups(user) do
    time = Timex.to_unix Timex.now

    for group <- user.active_groups do
      response = HTTPotion.get "https://api.vk.com/method/wall.get",
        query: %{owner_id: -String.to_integer(group), access_token: user.access_token, extended: 1}

      list = response.body
        |> Poison.decode!
        |> Map.get("response")
      group = List.first(list["groups"])
      [count | objects] = list["wall"]

      if is_nil(user.last_checked_at) do
        text = List.first(objects)["text"]

        HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendMessage",
              query: %{chat_id: user.telegram_chat_id, text: format_message(group, text), parse_mode: "Markdown"}
      else
        for object <- objects do
          if object["date"] > user.last_checked_at do
            HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendMessage",
              query: %{chat_id: user.telegram_chat_id, text: format_message(group, object["text"]), parse_mode: "Markdown"}
          end
        end
      end
    end

    user |> Ecto.Changeset.change(%{last_checked_at: time}) |> VkBots.Repo.update
  end

  defp format_message(group, text) do
    "[#{group["name"]}](vk.com/#{group["screen_name"]}): #{String.replace(text, "<br>", "\n")}"
  end
end
