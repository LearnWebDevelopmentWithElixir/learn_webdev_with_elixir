defmodule LearnWebdevWithElixir.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias LearnWebdevWithElixir.Content.Post.Comment
  alias LearnWebdevWithElixir.Accounts.User

  schema "posts" do
    field :body, :string
    field :title, :string
    belongs_to :author, User
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> unique_constraint(:title)
  end
end
