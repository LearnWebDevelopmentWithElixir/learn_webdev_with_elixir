defmodule LearnWebdevWithElixirWeb.AdminController do
  use LearnWebdevWithElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end