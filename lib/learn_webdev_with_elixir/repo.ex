defmodule LearnWebdevWithElixir.Repo do
  use Ecto.Repo,
    otp_app: :learn_webdev_with_elixir,
    adapter: Ecto.Adapters.Postgres
end
