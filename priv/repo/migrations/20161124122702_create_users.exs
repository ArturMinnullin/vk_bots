defmodule VkBots.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :avatar, :string
      add :email, :string
      add :access_token, :string
      add :uid, :string

      timestamps
    end
  end
end
