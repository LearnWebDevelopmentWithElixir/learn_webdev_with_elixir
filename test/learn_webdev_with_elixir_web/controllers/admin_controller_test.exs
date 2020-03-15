defmodule LearnWebdevWithElixirWeb.AdminControllerTest do
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

  describe "index" do
    setup [:signed_admin]
    @tag run: true
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.admin_path(conn, :index))
      assert html_response(conn, 200) =~ "Users"
    end
  end


end
