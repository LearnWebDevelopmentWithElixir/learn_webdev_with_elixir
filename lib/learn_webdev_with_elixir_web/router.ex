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

  pipeline :admin do
    plug LearnWebdevWithElixir.Policies, {:admin_permission, "admin"}
  end

  # pipeline :admin do
  #   plug LearnWebdevWithElixirWeb.Policies, {:admin_permission, "dashboard"}
  # end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LearnWebdevWithElixirWeb do
    pipe_through([:browser, :logged_in, :admin])

    get("/admin", AdminController, :index)
    resources "/pages", PageController, only: [:new, :index, :create, :edit, :update, :delete]
    resources "/users", UserController, only: [:index, :show, :create, :edit, :update, :delete]

    resources("/posts", PostController, only: [:new, :index, :create, :edit, :update, :delete])

    get("/posts/sort_posts", PostController, :sort_posts)

    post("/posts/save_posts_order", PostController, :save_posts_order)
  end

  scope "/", LearnWebdevWithElixirWeb do
    pipe_through(:browser)

    resources "/pages", PageController, only: [:show]

    get("/", PostController, :list)

    resources("/posts", PostController, except: [:new, :index, :create, :edit, :update, :delete]) do
      resources("/comments", CommentController)
    end

    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)

    get("/sign-in", SessionController, :new)
    post("/sign-in", SessionController, :create)
    delete("/sign-out", SessionController, :delete)

    post("/subscribe", SubscribersController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnWebdevWithElixirWeb do
  #   pipe_through :api
  # end
end
