use Mix.Config

config :camp_with_dennis_2019, CampWithDennis2019Web.Endpoint,
  url: [host: "campwithdennis.com", port: 443],
  http: [port: 2267],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

config :camp_with_dennis_2019, CampWithDennis2019Web.Endpoint, server: true

config :camp_with_dennis_2019, CampWithDennis2019.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "camp_with_dennis_2019_prod",
  hostname: "localhost",
  pool_size: 15

# Finally import any environment specific configuration
import_config "/var/apps/camp_with_dennis_2019/*.exs"
