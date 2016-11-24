defmodule VkBots.Router do
  use VkBots.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VkBots do
    pipe_through :browser

    get "/", PageController, :index
    resources "/groups", GroupsController, only: [:create, :delete]
  end

  scope "/auth", VkBots do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
