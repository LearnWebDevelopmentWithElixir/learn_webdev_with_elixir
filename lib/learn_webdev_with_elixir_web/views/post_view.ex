defmodule LearnWebdevWithElixirWeb.PostView do
  use LearnWebdevWithElixirWeb, :view
  use Timex

  def list_date_format(date, format_string \\ "%B %d, %Y") do
    Timex.format!(date, format_string, :strftime)
  end

  def user_name(post) do
    post.user.first_name
  end
end
