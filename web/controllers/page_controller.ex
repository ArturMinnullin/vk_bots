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
      [_count | groups] = list
    end

    render conn, "index.html", current_user: user, groups: groups
  end

  def letsencrypt(conn, params) do
    text conn, "2WCQ4pXA7uKS89Va-jYW4sexbv3knl9OqGxseMhISBE.ogUgWHtSkEL5bnPogw92J3LNIU-e3Tb0tiDxhI8jZYs"
  end
end
