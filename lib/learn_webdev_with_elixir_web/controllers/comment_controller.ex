defmodule LearnWebdevWithElixirWeb.CommentController do
  use LearnWebdevWithElixirWeb, :controller
  alias LearnWebdevWithElixir.Content

  def create(%{assigns: %{current_user: current_user}} = conn, %{"post_id" => post_id, "comment" => comment_params}) do
    post = Content.get_post!(post_id)
    # This is a comment
    case Content.create_comment(post, current_user,comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Issue creating comment")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end
  
end
