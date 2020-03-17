defmodule LearnWebdevWithElixirWeb.Plugs.EnsureUser do
  @moduledoc """
  Verify a user is in the session
  """ 
  import Plug.Conn
  import Phoenix.Controller

  alias LearnWebdevWithElixirWeb.Router.Helpers, as: Routes

  def init(default), do: default

  @doc """
    If current_user exists, return connection object as is.
    If current_user does not exist and request is comming from comments creation, redirect to login and modify last_path to post detail page
    Else redirect to login and set current path as last_path
  """
  def call(conn, _opts) do

    current_user = conn.assigns[:current_user]
    cond do
      !is_nil(current_user) -> 
        conn

      String.ends_with?(conn.request_path,"comments") ->
        modified_path = conn.request_path |> String.replace_trailing("/comments","")
        uri = %URI{path: modified_path, query: conn.query_string}
        conn
        |> put_flash(:info, "You must sign in first.")
        |> put_session(:last_path, URI.to_string(uri))
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()   

      true ->
        uri = %URI{path: conn.request_path, query: conn.query_string}

        conn
        |> put_flash(:info, "You must sign in first.")
        |> put_session(:last_path, URI.to_string(uri))
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()   
    end
  end
end
