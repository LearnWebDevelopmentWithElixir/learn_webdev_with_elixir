defmodule LearnWebdevWithElixir.Subscribers do
  alias LearnWebdevWithElixir.Subscribers.Email
  alias LearnWebdevWithElixir.Repo

  def change_email(%Email{} = email) do
    Email.changeset(email, %{})
  end

  def create(attrs \\ %{}) do
    %Email{}
    |> Email.changeset(attrs)
    |> Repo.insert()
  end
end
