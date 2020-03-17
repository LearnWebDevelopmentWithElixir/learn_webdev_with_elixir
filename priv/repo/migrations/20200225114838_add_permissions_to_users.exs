defmodule LearnWebdevWithElixir.Repo.Migrations.AddPermissionsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :permissions, {:array, :string}
    end
  end
end
