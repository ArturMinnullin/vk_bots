defmodule VkBots.Repo.Migrations.AddBotIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bot_id, :string
    end
  end
end
