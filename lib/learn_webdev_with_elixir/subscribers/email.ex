defmodule LearnWebdevWithElixir.Subscribers.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
