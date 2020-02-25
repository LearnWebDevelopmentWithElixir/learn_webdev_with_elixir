defmodule LearnWebdevWithElixirWeb.Router do
  use LearnWebdevWithElixirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug LearnWebdevWithElixirWeb.Plugs.FetchUser
    plug LearnWebdevWithElixirWeb.Plugs.EmailChangeset
  end

  pipeline :logged_in do
    plug LearnWebdevWithElixirWeb.Plugs.EnsureUser
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LearnWebdevWithElixirWeb do
    pipe_through(:browser)

    resources("/users", UserController)
    resources("/pages", PageController)

    get("/", PostController, :list)

    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)

    get("/sign-in", SessionController, :new)
    post("/sign-in", SessionController, :create)
    delete("/sign-out", SessionController, :delete)

    post("/subscribe", SubscribersController, :create)
  end

  scope "/", LearnWebdevWithElixirWeb do
    pipe_through([:browser, :logged_in])

    resources("/posts", PostController) do
      resources("/comments", CommentController)
      get("/list", PostController, :list)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnWebdevWithElixirWeb do
  #   pipe_through :api
  # end
end
