defmodule LearnWebdevWithElixirWeb.ErrorViewTest do
  use LearnWebdevWithElixirWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @tag run: true
  test "renders 404.html" do
    assert render_to_string(LearnWebdevWithElixirWeb.ErrorView, "404.html", []) == "Not Found"
  end
  @tag run: true
  test "renders 500.html" do
    assert render_to_string(LearnWebdevWithElixirWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
