defmodule LearnWebdevWithElixir.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:posts, [:title])
    create index(:posts, [:author_id])
  end
end
