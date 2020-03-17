defmodule LearnWebdevWithElixir.Content.Post.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias LearnWebdevWithElixir.Content.Post
  alias LearnWebdevWithElixir.Accounts.User

  schema "comments" do
    field :body, :string
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
