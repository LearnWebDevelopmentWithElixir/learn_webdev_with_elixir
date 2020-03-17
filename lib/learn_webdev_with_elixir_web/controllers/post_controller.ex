defmodule LearnWebdevWithElixirWeb.PostController do
  use LearnWebdevWithElixirWeb, :controller

  alias LearnWebdevWithElixir.Content
  alias LearnWebdevWithElixir.Content.{Post, Post.Comment}

  def list(conn, _params) do
    conn
    |> render("list.html")
  end

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def sort_posts(conn, _params) do
    conn
    |> render("sort_posts.html")
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    %{current_user: user} = conn.assigns

    case Content.create_post(user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    comment_changeset = Content.change_comment(%Comment{})

    render(conn, "show.html",
      post: post,
      comment_changeset: comment_changeset
    )
  end

  def edit(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    changeset = Content.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get_post!(id)

    case Content.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    {:ok, _post} = Content.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def save_posts_order(conn, params) do
    Content.save_posts_order(params)
    text(conn, "done")
  end
end
