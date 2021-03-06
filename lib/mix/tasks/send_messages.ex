defmodule Mix.Tasks.SendMessages do
  use Mix.Task

  import Mix.Ecto

  @shortdoc "Send messages to all users"

  def run(_args) do
    ensure_started(VkBots.Repo, [])
    Application.ensure_all_started(:timex)
    Application.ensure_all_started(:ecto)

    HTTPotion.start

    for user <- VkBots.Repo.all(VkBots.User), do: get_groups(user)
  end

  defp get_groups(user) do
    for group <- user.active_groups do
      response = HTTPotion.get "https://api.vk.com/method/wall.get",
        query: %{owner_id: -String.to_integer(group), access_token: user.access_token, extended: 1}

      list = response.body
        |> Poison.decode!
        |> Map.get("response")

      unless is_nil(list["groups"]) do
        group = List.first(list["groups"])
        [_count | objects] = list["wall"]

        if is_nil(user.last_checked_at) do
          send_message(user, group, List.first(objects))
        else
          send_message(user, group, objects)
        end
      end
    end

    VkBots.User.changeset(user, %{last_checked_at: Timex.to_unix(Timex.now)}) |> VkBots.Repo.update
  end

  defp send_message(user, group, object) when is_list(object) do
    for single_object <- object do
      if single_object["date"] > user.last_checked_at, do: send_message(user, group, single_object)
    end
  end

  defp send_message(user, group, object) do
    text = object["text"]
    HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendMessage",
      query: %{chat_id: user.telegram_chat_id, text: format_message(group, text), parse_mode: "HTML"}

    unless is_nil(object["attachments"]) do
      object["attachments"]
        |> Enum.filter_map(fn(x) -> Map.has_key?(x, "photo") end, &send_image(&1, user))

      object["attachments"]
        |> Enum.filter_map(fn(x) -> Map.has_key?(x, "video") end, &send_video(&1, user))
    end
  end

  defp send_image(%{"photo" => %{"src_big" => url}} = _image, user) do
    HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendPhoto",
      query: %{chat_id: user.telegram_chat_id, photo: url}
  end

  defp send_video(%{"video" => %{"owner_id" => owner, "vid" => vid, "title" => title}} = _video, user) do
    HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendMessage",
      query: %{chat_id: user.telegram_chat_id, text: "<a href='https://vk.com/video#{owner}_#{vid}'>#{title}</a>", parse_mode: "HTML"}
  end

  defp format_message(group, text) do
    "<a href='vk.com/#{group["screen_name"]}'>#{group["name"]}</a>\n\n#{String.replace(text, "<br>", "\n")}"
  end
end
