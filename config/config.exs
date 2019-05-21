# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :quiz_system,
  ecto_repos: [QuizSystem.Repo]

# Configures the endpoint
config :quiz_system, QuizSystemWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oVNqXOE/8EgN/nmomIkh7p6ry4k+PBvhURc5uHhmjsV+rhRN2gM/ELV5LIaIB3bH",
  render_errors: [view: QuizSystemWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuizSystem.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
