import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :teller, TellerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "c38baUNUrNpqFQhGGpC9Fqz6o3rrApAi8iewGaV8KOBVCP/u7rxhLN/HNYie7ptY",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
