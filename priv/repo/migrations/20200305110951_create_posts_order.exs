defmodule LearnWebdevWithElixir.Repo.Migrations.CreatePostsOrder do
  use Ecto.Migration

  def change do
    create table(:posts_order) do
      add :order, :string

      timestamps()
    end

  end
end
