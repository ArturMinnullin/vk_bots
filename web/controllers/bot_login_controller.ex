defmodule VkBots.BotLoginController do
  use VkBots.Web, :controller

  alias VkBots.User

  def request(conn, params) do
    unless is_nil(params["message"]["text"]) do
      text = String.split(params["message"]["text"], " ")

      if List.first(text) == "/start" do
        user = Repo.get_by(User, uid: List.last(text))
        unless is_nil(user) do
          changeset = User.changeset(user, %{telegram_chat_id: params["message"]["chat"]["id"]})
          Repo.update(changeset)

          HTTPotion.get "https://api.telegram.org/bot#{System.get_env("TELEGRAM_KEY")}/sendMessage",
            query: %{chat_id: params["message"]["chat"]["id"], text: "Привет! Скоро сообщения начнут приходить :)", parse_mode: "HTML"}
        end
      end
    end

    conn |> send_resp(200, "")
  end
end
