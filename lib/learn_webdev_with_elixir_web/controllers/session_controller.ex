defmodule LearnWebdevWithElixirWeb.SessionController do
  use LearnWebdevWithElixirWeb, :controller

  alias LearnWebdevWithElixir.Accounts

  def new(conn, _params) do
    conn
    |> put_layout("session.html")
    |> assign(:changeset, Accounts.new())
    |> render("new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.validate_login(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have signed in.")
        |> put_session(:user_token, user.token)
        |> after_sign_in_redirect(Routes.post_path(conn, :list))

      {:error, :invalid} ->
        conn
        |> put_flash(:error, "Your email or password is invalid")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: Routes.post_path(conn, :list))
  end

  @doc """
  Redirect to the last seen page after being asked to sign in
  Or the home page
  """
  def after_sign_in_redirect(conn, default_path) do
    case get_session(conn, :last_path) do
      nil ->
        redirect(conn, to: default_path)

      path ->
        conn
        |> put_session(:last_path, nil)
        |> redirect(to: path)
    end
  end
end
