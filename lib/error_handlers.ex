defmodule LearnWebdevWithElixir.ErrorHandlers do
  use Phoenix.Controller

  def unauthenticated(conn, message) do
    conn
    |> put_flash(:error, message || "Unauthorized")
    |> redirect(to: "/")
    |> halt()
  end
end
