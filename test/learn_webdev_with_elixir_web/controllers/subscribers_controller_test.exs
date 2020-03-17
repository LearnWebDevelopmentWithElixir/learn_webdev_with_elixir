defmodule LearnWebdevWithElixirWeb.SubscribersControllerTest do
  use LearnWebdevWithElixirWeb.ConnCase
  use LearnWebdevWithElixir.FixtureParams

  describe "Add email to subscription list" do
    @tag run: true
    test "successful", %{conn: conn} do
      conn = post(conn, Routes.subscribers_path(conn, :create),email: @valid_subscriber_attrs)

      assert redirected_to(conn) == Routes.post_path(conn, :list)
    end

    @tag run: true
    test "failure - invalid email", %{conn: conn} do      

      conn = post(conn, Routes.subscribers_path(conn, :create), email: @invalid_subscriber_attrs)

      assert html_response(conn, 302)
    end

    @tag run: true
    test "failure - username already part of list", %{conn: conn} do      

        conn = post(conn, Routes.subscribers_path(conn, :create),email: @valid_subscriber_attrs)
        conn = post(conn, Routes.subscribers_path(conn, :create), email: @valid_subscriber_attrs)

      assert html_response(conn, 302)
    end    
  end
end