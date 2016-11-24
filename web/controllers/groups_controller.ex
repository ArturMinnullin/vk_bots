defmodule VkBots.GroupsController do
  use VkBots.Web, :controller

  def create(conn, params) do
    user = get_session(conn, :current_user)
  end

  def destroy(conn, params) do
    user = get_session(conn, :current_user)

  end
end
