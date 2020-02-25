defmodule LearnWebdevWithElixir.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :body, :text

      timestamps()
    end

    create unique_index(:pages, [:title])
  end
end
