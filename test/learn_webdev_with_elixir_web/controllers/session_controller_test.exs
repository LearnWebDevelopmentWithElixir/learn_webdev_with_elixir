defmodule LearnWebdevWithElixirWeb.SessionControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase
  use LearnWebdevWithElixir.FixtureParams

  describe "sign in a user" do
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
  end
end
