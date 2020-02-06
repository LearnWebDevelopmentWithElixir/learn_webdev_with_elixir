# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :learn_webdev_with_elixir,
  ecto_repos: [LearnWebdevWithElixir.Repo]

# Configures the endpoint
config :learn_webdev_with_elixir, LearnWebdevWithElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eoS+v+N1VxBlvmtTwUyKhC2Cqx+LCfYjeiiMPLm7Qu4+FDg12c6wpze6P4Y5KKLJ",
  render_errors: [view: LearnWebdevWithElixirWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LearnWebdevWithElixir.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :stein_phoenix, :views, error_helpers: LearnWebdevWithElixirWeb.ErrorHelpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
