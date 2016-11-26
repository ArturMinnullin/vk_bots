defmodule Mix.Tasks.SendMessages do
  use Mix.Task

  import Mix.Ecto

  @shortdoc "Send messages to all users"

  def run(_args) do
    ensure_started(VkBots.Repo, [])
    HTTPotion.start

    users = VkBots.Repo.all(VkBots.User)
    for user <- users, do: get_groups(user)
  end

  defp get_groups(user) do
    for group <- user.active_groups do
      response = HTTPotion.get "https://api.vk.com/method/wall.get",
        query: %{owner_id: -String.to_integer(group)}

      list = response.body
        |> Poison.decode!
        |> Map.get("response")
      [count | groups] = list

      text = List.first(groups)["text"]

      HTTPotion.get "https://api.telegram.org/bot188180966:AAGJvjVZadL9LGIVA_eLXoS06OP6VP1lhzA/sendMessage",
        query: %{chat_id: user.telegram_chat_id, text: text}
    end
  end
end
