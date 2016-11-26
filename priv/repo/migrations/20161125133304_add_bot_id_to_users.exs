defmodule VkBots.Repo.Migrations.AddBotIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :telegram_chat_id, :integer
    end
  end
end
