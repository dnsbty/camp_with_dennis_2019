use Mix.Config

# Configure your database
config :camp_with_dennis_2019, CampWithDennis2019.Repo,
  username: "postgres",
  password: "postgres",
  database: "camp_with_dennis_2019_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :camp_with_dennis_2019, CampWithDennis2019Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
