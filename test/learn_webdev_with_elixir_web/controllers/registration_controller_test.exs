defmodule LearnWebdevWithElixirWeb.RegistrationControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase
  use LearnWebdevWithElixir.FixtureParams

  describe "registering a new user" do

    @tag run: true
    test "new", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))

      assert html_response(conn, 200) =~ "Register"
    end

    @tag run: true
    test "successful", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), user: @valid_user_attrs)

      assert redirected_to(conn) == Routes.post_path(conn, :list)
    end

    @tag run: true
    test "failure", %{conn: conn} do      

      conn = post(conn, Routes.registration_path(conn, :create), user: @invalid_user_attrs)

      assert html_response(conn, 422)
    end
  end
end
