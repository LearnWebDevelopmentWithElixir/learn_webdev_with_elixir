defmodule LearnWebdevWithElixirWeb.Plugs.EmailChangeset do
  import Plug.Conn

  alias LearnWebdevWithElixir.Subscribers
  alias LearnWebdevWithElixir.Subscribers.Email

  def init(default), do: default

  def call(conn, _default) do
    email_changeset = Subscribers.change_email(%Email{})
    assign(conn, :email_changeset, email_changeset)
  end
end
