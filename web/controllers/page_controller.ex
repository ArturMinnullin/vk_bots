defmodule VkBots.PageController do
  use VkBots.Web, :controller

  def index(conn, _params) do
    user = get_session(conn, :current_user)

    response = HTTPotion.get "https://api.vk.com/method/groups.get",
      query: %{access_token: user.access_token, extended: 1}
    list = response.body
      |> Poison.decode!
      |> Map.get("response")
    [count | groups] = list

    require IEx; IEx.pry
    render conn, "index.html", current_user: user, groups: groups
  end
end
