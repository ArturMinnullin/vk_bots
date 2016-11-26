defmodule VkBots.User do
  use VkBots.Web, :model

  schema "users" do
    field :name, :string
    field :avatar, :string
    field :email, :string
    field :access_token, :string
    field :uid, :string
    field :telegram_chat_id, :integer
    field :active_groups, {:array, :string}, default: []

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :avatar, :email, :access_token, :uid, :active_groups, :telegram_chat_id])
    |> validate_required([:name, :access_token, :uid])
    |> validate_format(:email, ~r/@/)
  end
end
