defmodule LearnWebdevWithElixir.Content.PostsOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_order" do
    field :order, :string

    timestamps()
  end

  @doc false
  def changeset(posts_order, attrs) do
    posts_order
    |> cast(attrs, [:order])
    |> validate_required([:order])
  end
end
