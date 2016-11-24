defmodule VkBots.FindOrCreateUserFromAuth do
  alias VkBots.User
  alias VkBots.Repo

  def call(%Ueberauth.Auth{info: info, uid: uid} = auth) do
    user = find_user(uid)

    if user, do: {:ok, user}, else: create_user(auth)
  end

  defp find_user(uid) do
    str = Integer.to_string(uid)

    Repo.get_by(User, uid: str)
  end

  defp create_user(%Ueberauth.Auth{info: info, uid: uid} = auth) do
    user_info = %{
      uid: Integer.to_string(uid),
      access_token: credentials(auth),
      name: info.name,
      email: info.email,
      avatar: info.image
    }

    changeset = User.changeset(%User{}, user_info)
    Repo.insert(changeset)
  end

  defp credentials(%{extra: %Ueberauth.Auth.Extra{raw_info: %{token: %OAuth2.AccessToken{access_token: access_token}}}} = auth) do
    access_token
  end
end
