defmodule LearnWebdevWithElixir.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias LearnWebdevWithElixir.Content.Post
  alias LearnWebdevWithElixir.Content.Post.Comment

  schema "users" do
    field :name, :string
    has_many :posts, Post
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
