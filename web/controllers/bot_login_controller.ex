defmodule VkBots.BotLoginController do
  use VkBots.Web, :controller

  alias VkBots.User

  def request(conn, params) do
    text = String.split(params["message"]["text"], " ")

    if List.first(text) == "/start" do
      user = Repo.get_by(User, uid: List.last(text))
      changeset = User.changeset(user, %{telegram_chat_id: params["message"]["chat"]["id"]})

      Repo.update(changeset)
    end

    conn |> send_resp(200, "")
  end
end
