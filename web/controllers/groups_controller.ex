defmodule VkBots.GroupsController do
  use VkBots.Web, :controller

  alias VkBots.Repo
  alias VkBots.User

  def create(conn, params) do
    conn = fetch_session(conn)
    session = get_session(conn, :current_user)

    user = Repo.get(User, session.id)
    array = user.active_groups ++ [Integer.to_string(params["gid"])]

    { status, updated_user } = user |> Ecto.Changeset.change(%{active_groups: array}) |> Repo.update

    conn
      |> put_session(:current_user, updated_user)
      |> send_resp(status, "")
  end

  def delete(conn, params) do
    conn = fetch_session(conn)
    session = get_session(conn, :current_user)
    user = Repo.get!(User, session.id)
    array = List.delete(user.active_groups, params["id"])

    { status, updated_user } = user |> Ecto.Changeset.change(%{active_groups: array}) |> Repo.update

    conn
      |> put_session(:current_user, updated_user)
      |> send_resp(status, "")
  end
end
