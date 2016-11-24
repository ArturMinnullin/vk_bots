defmodule VkBots.PageController do
  use VkBots.Web, :controller

  alias VkBots.Repo
  alias VkBots.User

  def index(conn, _params) do
    session = get_session(conn, :current_user)

    if session do
      user = Repo.get(User, session.id)
      response = HTTPotion.get "https://api.vk.com/method/groups.get",
        query: %{access_token: user.access_token, extended: 1}
      list = response.body
        |> Poison.decode!
        |> Map.get("response")
      [count | groups] = list
    end

    render conn, "index.html", current_user: user, groups: groups
  end
end
