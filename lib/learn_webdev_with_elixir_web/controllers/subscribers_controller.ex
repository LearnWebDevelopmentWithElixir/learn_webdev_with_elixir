defmodule LearnWebdevWithElixirWeb.SubscribersController do
  use LearnWebdevWithElixirWeb, :controller

  alias LearnWebdevWithElixir.Subscribers

  action_fallback(Web.FallbackController)

  def create(conn, params) do
    email = params["email"]

    case Recaptcha.verify(params["g-recaptcha-response"]) do
      {:ok, response} ->
        case Subscribers.create(email) do
          {:ok, subscriber} ->
            conn
            |> put_flash(:info, "Post created successfully.")
            |> redirect(to: Routes.post_path(conn, :list))

          {:error, changeset} ->
            conn
            |> put_flash(:error, "Post created successfully.")
            |> redirect(to: Routes.post_path(conn, :list))
        end

      {:error, errors} ->
        conn
        |> put_flash(:error, "There was an error, please try again")
        |> redirect(to: Routes.post_path(conn, :list))
    end
  end
end
