import Config

config :freedpp, event_stores: [Freedpp.EventStore]

config :freedpp, Freedpp.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "freedpp_db",
  hostname: "localhost",
  port: 5433,
  pool_size: 10

config :commanded, default_event_store: Freedpp.EventStore

config :freedpp, Freedpp.Repo,
  username: "postgres",
  password: "postgres",
  database: "freedpp_db",
  hostname: "localhost",
  port: 5433,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :freedpp, ecto_repos: [Freedpp.Repo]
