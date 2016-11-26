defmodule Mix.Tasks.SendMessages do
  use Mix.Task

  @shortdoc "Send messages to all users"

  def run(_args) do
    response = HTTPotion.get "https://api.vk.com/method/wall.get",
        query: %{owner_id: 1}

    list = response.body
      |> Poison.decode!
      |> Map.get("response")
    [count | groups] = list
  end
end
