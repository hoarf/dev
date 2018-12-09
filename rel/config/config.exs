use Mix.Config

port = String.to_integer(System.get_env("PORT") || "8080")

config :app, App.Endpoint,
  http: [port: port],
  url: [host: System.get_env("HOSTNAME"), port: port],
  root: ".",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :app, MarvelAPI, private_key: System.get_env("MARVEL_PRIVATE_KEY")
