defmodule VkBots.Repo.Migrations.AddLastCheckedAtToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_checked_at, :integer
    end
  end
end
