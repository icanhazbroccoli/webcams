# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :whitebox,
  ecto_repos: [Whitebox.Repo]

# Configures the endpoint
config :whitebox, Whitebox.Endpoint,
  url: [host: "0.0.0.0"],
  secret_key_base: "+33RdkScsCpYAktG7MB5PdWIlPRLafHdxPTHp9EVMT9sUXsk4VkCCZh4HJ+/Ux6i",
  render_errors: [view: Whitebox.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Whitebox.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :whitebox, Whitebox.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATA_DB_USER"),
  password: System.get_env("DATA_DB_PASS"),
  hostname: System.get_env("DATA_DB_HOST"),
  database: "gonano",
  pool_size: 10

config :guardian, Guardian,
  issuer: "Whitebox.#{Mix.env}",
  ttl: {1, :days},
  verify_issuer: true,
  serializer: Protego.Auth.GuardianSerializer,
  secret_key: "01c1d6f4083d8aa5c7b8c246ade95139620ef8effb009edde934e0ec3b28090a"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
