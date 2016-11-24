defmodule VkBots.AuthController do
  use VkBots.Web, :controller
  plug Ueberauth

  def request(conn, params) do
    render conn
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case FindOrCreateUserFromAuth.call(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
