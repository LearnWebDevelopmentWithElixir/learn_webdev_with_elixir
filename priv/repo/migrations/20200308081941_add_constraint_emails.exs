defmodule LearnWebdevWithElixir.Repo.Migrations.AddConstraintEmails do
  use Ecto.Migration

  def change do
    create unique_index(:emails, [:email])
  end
end
