defmodule LearnWebdevWithElixirWeb.PageControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase

  alias LearnWebdevWithElixir.Accounts  
  alias LearnWebdevWithElixir.Fixture
  use LearnWebdevWithElixir.FixtureParams

  defp signed_admin(_) do
    {:ok, user} = Fixture.user_fixture()
    {:ok, user} = Accounts.update_user(user, @update_user_attrs)
    conn = post(build_conn(), Routes.session_path(build_conn(), :create), user: %{email: user.email, password: "password"})
    {:ok, conn: conn}
  end

  defp create_page(_) do
    {:ok, page} = Fixture.page_fixture()
    {:ok, page: page}
  end  

  describe "index" do
    setup [:signed_admin]
    @tag run: true
    test "lists all pages", %{conn: conn} do      
      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pages"
    end
  end

  describe "new page" do
    setup [:signed_admin]
    @tag run: true
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "create page" do
    setup [:signed_admin]
    @tag run: true
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :create), page: @valid_page_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.page_path(conn, :show, id)

    end

    @tag run: true
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :create), page: @invalid_page_attrs)
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "edit page" do
    setup [:signed_admin, :create_page]
    
    @tag run: true
    test "renders form for editing chosen page", %{conn: conn, page: page} do
      conn = get(conn, Routes.page_path(conn, :edit, page))
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "update page" do
    setup [:create_page, :signed_admin]

    @tag run: true
    test "redirects when data is valid", %{conn: conn, page: page} do
      conn = put(conn, Routes.page_path(conn, :update, page), page: @update_page_attrs)
      assert redirected_to(conn) == Routes.page_path(conn, :show, page)

      conn = get(conn, Routes.page_path(conn, :show, page))
      assert html_response(conn, 200) =~ "some updated body"
    end

    @tag run: true
    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put(conn, Routes.page_path(conn, :update, page), page: @invalid_page_attrs)
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "delete page" do
    setup [:create_page, :signed_admin]

    @tag run: true
    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete(conn, Routes.page_path(conn, :delete, page))
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.page_path(conn, :show, page))
      end
    end
  end
end
