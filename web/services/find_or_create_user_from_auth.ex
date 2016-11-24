defmodule VkBots.FindOrCreateUserFromAuth do
  def call(%Ueberauth.Auth{info: info, uid: uid} = auth) do
  end

  defp basic_info(%Ueberauth.Auth.Info{email: email, name: name, image: avatar} = info) do
    %{email: email, name: name, avatar: avatar}
  end
end
