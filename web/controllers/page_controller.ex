defmodule VkBots.PageController do
  use VkBots.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
