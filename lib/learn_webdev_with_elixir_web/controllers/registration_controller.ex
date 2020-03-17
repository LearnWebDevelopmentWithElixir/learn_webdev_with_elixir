defmodule LearnWebdevWithElixirWeb.RegistrationController do
  use LearnWebdevWithElixirWeb, :controller

  alias LearnWebdevWithElixir.Accounts

  action_fallback(Web.FallbackController)

  plug(:put_layout, "session.html")

  def new(conn, _params) do
    conn
    |> assign(:changeset, Accounts.new())
    |> render("new.html")
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> put_session(:user_token, user.token)
        |> redirect(to: Routes.post_path(conn, :list))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "There was an error, please try again")
        |> put_status(422)
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end
end
