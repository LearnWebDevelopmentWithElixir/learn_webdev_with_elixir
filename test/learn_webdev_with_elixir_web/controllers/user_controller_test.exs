defmodule LearnWebdevWithElixirWeb.UserControllerTest do
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

  defp signed_user(conn) do
    token = conn |> get_session(:user_token)
    Accounts.from_token(token)
  end  

  describe "index" do
    setup [:signed_admin]
    @tag run: true
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index, posts: []))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "create user" do
    setup [:signed_admin]
    @tag run: true
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @valid_user_attrs_1)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :show, id)

      conn = get(conn, Routes.user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User"
    end

    #No valid business case for this use case
    @tag run: true
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_user_attrs)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "edit user" do
    setup [:signed_admin]

    @tag run: true
    test "renders form for editing chosen user", %{conn: conn} do
      {:ok, user} = signed_user(conn)
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:signed_admin]

    @tag run: true
    test "redirects when data is valid", %{conn: conn} do
      {:ok, user} = signed_user(conn)
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_user_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :show, user, posts: [])

    end

    @tag run: true
    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, user} = signed_user(conn)
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_user_update_attrs, posts: [])
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:signed_admin]
    @tag run: true
    #No valid business case for this use case    
    test "deletes chosen user", %{conn: conn} do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs_1)
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.user_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

end
