defmodule LearnWebdevWithElixirWeb.PostControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase
  use LearnWebdevWithElixir.FixtureParams

  alias LearnWebdevWithElixir.Accounts  
  alias LearnWebdevWithElixir.Fixture

  defp signed_admin(_) do    
    {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
    {:ok, user} = Accounts.update_user(user, @update_user_attrs)
    conn = post(build_conn(), Routes.session_path(build_conn(), :create), user: %{email: user.email, password: "password"})
    {:ok, conn: conn}
  end

  defp signed_non_admin(_) do    
    {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
    conn = post(build_conn(), Routes.session_path(build_conn(), :create), user: %{email: user.email, password: "password"})
    {:ok, conn: conn}
  end  

  defp create_post(_) do
    {:ok, post} = Fixture.post_fixture()
    {:ok, post: post}
  end

  describe "index" do
    setup [:signed_admin]
    @tag run: true
    test "lists all posts", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @valid_login_attrs)
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "index for unsigned user" do
    @tag run: true
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :list))
      assert html_response(conn, 200) =~ "Posts"
    end
  end

  describe "new post" do
    setup [:signed_admin]
    @tag run: true
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :new))
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "new post by non admin" do
    setup [:signed_non_admin]
    @tag run: true
    test "redirect to sign-in", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :new))
      assert html_response(conn, 302)
    end
  end

  describe "create post" do
    setup [:signed_admin]
    @tag run: true
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @valid_post_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    end

    @tag run: true
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @invalid_post_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:signed_admin, :create_post]
  
    @tag run: true
    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:signed_admin, :create_post]

    @tag run: true
    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @update_post_attrs)
      assert redirected_to(conn) == Routes.post_path(conn, :show, post)

      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ "some updated body"
    end

    @tag run: true
    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @invalid_post_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post, :signed_admin]

    @tag run: true
    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_path(conn, :show, post))
      end
    end
  end

  describe "sort posts" do
    setup [:signed_admin]
    @tag run: true
    test "sorted posts", %{conn: conn} do
      _post_list = Fixture.posts_fixture()

      conn = get(conn, Routes.post_path(conn, :sort_posts))
      assert html_response(conn, 200) =~ "Sort Post"

    end

    @tag run: true
    test "save sort order", %{conn: conn} do
      post_list = Fixture.posts_fixture()
      ids = Enum.map(post_list, fn post->
        post.id
      end)

      sort_order = Enum.shuffle(ids) |> Enum.join(",") 
      conn = post(conn, Routes.post_path(conn, :save_posts_order), order: sort_order)
      assert text_response(conn, 200) =~ "done"

    end    

  end

  describe "create comment" do
    setup [:create_post, :signed_non_admin]
    @tag run: true
    test "successfully", %{conn: conn, post: post} do
      conn = post(conn, Routes.post_comment_path(conn, :create, post.id),comment: @valid_comment_attrs)
      assert redirected_to(conn) == Routes.post_path(conn, :show, post)

      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ @valid_comment_attrs.body
    end

    @tag run: true
    test "action from a non-signed in user is redirected to sign in", %{post: post} do
      conn = build_conn()
      conn = post(conn, Routes.post_comment_path(conn, :create, post.id),comment: @valid_comment_attrs)
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end

    @tag run: true
    test "error in creating", %{conn: conn, post: post} do
      conn = post(conn, Routes.post_comment_path(conn, :create, post.id),comment: @invalid_comment_attrs)
      assert redirected_to(conn) == Routes.post_path(conn, :show, post)
    end    
  end
end
