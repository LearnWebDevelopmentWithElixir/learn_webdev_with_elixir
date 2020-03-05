defmodule LearnWebdevWithElixirWeb.SubscribersController do
  use LearnWebdevWithElixirWeb, :controller
  alias LearnWebdevWithElixir.Subscribers

  action_fallback(Web.FallbackController)

  @doc """
    Verify recaptcha and add valid email to subscribers list.    
    If email already a part of subscribers list, return subscription_failed with message
    If unable to verify captcha, return subscription_failed with message
  """
  def create(conn,  %{"email" =>email, "g-recaptcha-response" => recaptcha_response} = _params) do
    with  {:ok, _response} <- Recaptcha.verify(recaptcha_response),
          {:ok, _subscriber} <- Subscribers.create(email) do
            conn
              |> put_flash(:subscription_success, "Your subscription has been successful.")
              |> redirect(to: Routes.post_path(conn, :list))
    else
          {:error, %Ecto.Changeset{} = _changeset} ->
            conn
              |> put_flash(:subscription_failed, "Looks like you have already subscribed.")
              |> redirect(to: Routes.post_path(conn, :list))
          {:error, _error} ->
            conn
              |> put_flash(:subscription_failed, "There was an error, please try again.")
              |> redirect(to: Routes.post_path(conn, :list))        
    end
  end

  @doc """
    Non-captcha
    Add valid email to subscribers list
    If email already a part of subscribers list, return subscription_failed with message
  """
  def create(conn,  %{"email" =>email} = _params) do
    with  {:ok, _subscriber} <- Subscribers.create(email) do
            conn
              |> put_flash(:subscription_success, "Your subscription has been successful.")
              |> redirect(to: Routes.post_path(conn, :list))
    else
          {:error, %Ecto.Changeset{} = _changeset} ->
            conn
              |> put_flash(:subscription_failed, "Looks like you have already subscribed.")
              |> redirect(to: Routes.post_path(conn, :list))
        
    end
  end
end
