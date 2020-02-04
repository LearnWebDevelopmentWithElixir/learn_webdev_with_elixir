defmodule LearnWebdevWithElixirWeb.Router do
  use LearnWebdevWithElixirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LearnWebdevWithElixirWeb do
    pipe_through(:browser)

    resources("/users", UserController)

    resources("/posts", PostController) do
      resources("/comments", CommentController)
      get("/list", PostController, :list)
    end

    get("/", PostController, :list)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnWebdevWithElixirWeb do
  #   pipe_through :api
  # end
end
