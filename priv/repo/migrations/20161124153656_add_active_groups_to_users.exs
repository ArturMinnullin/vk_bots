defmodule VkBots.Repo.Migrations.AddActiveGroupsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :active_groups, {:array, :string}, default: []
    end
  end
end
