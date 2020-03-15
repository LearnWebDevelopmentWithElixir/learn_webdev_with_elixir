defmodule LearnWebdevWithElixirWeb.SessionControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase
  use LearnWebdevWithElixir.FixtureParams

  describe "sign in a user" do

    @tag run: true
    test "new", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))

      assert html_response(conn, 200) =~ "Welcome"
    end

    @tag run: true
    test "successful", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @valid_login_attrs)

      assert redirected_to(conn) == Routes.session_path(conn, :create)
    end

    @tag run: true
    test "failure - invalid password", %{conn: conn} do      

      conn = post(conn, Routes.session_path(conn, :create), user: @invalid_login_password_attrs)

      assert html_response(conn, 302)
    end

    @tag run: true
    test "failure - invalid username", %{conn: conn} do      

      conn = post(conn, Routes.session_path(conn, :create), user: @invalid_login_email_attrs)

      assert html_response(conn, 302)
    end    

    @tag runn: true
    test "successful after redirect", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @valid_post_attrs)

      conn = post(conn, Routes.session_path(conn, :create), user: @valid_login_attrs)

      assert redirected_to(conn) == Routes.session_path(conn, :create)
    end

  end
  describe "sign out user" do
    @tag run: true
    test "successfully", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @valid_login_attrs)
      assert redirected_to(conn) == Routes.session_path(conn, :create)

      conn = delete(conn, Routes.session_path(conn, :delete))
      assert redirected_to(conn) == Routes.post_path(conn, :list)
      
    end
  end
  
end
