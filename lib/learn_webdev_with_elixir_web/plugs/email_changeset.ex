defmodule LearnWebdevWithElixirWeb.Plugs.EmailChangeset do
  import Plug.Conn

  alias LearnWebdevWithElixir.Subscribers
  alias LearnWebdevWithElixir.Subscribers.Email
  alias LearnWebdevWithElixir.Content

  def init(default), do: default

  def call(conn, _default) do
    email_changeset = Subscribers.change_email(%Email{})
    posts = Content.list_posts()
    pages = Content.list_pages()
    assign(conn, :email_changeset, email_changeset) |> assign(:posts, posts) |> assign(:pages, pages)
  end
end
