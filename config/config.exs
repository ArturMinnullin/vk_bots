# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vk_bots,
  ecto_repos: [VkBots.Repo]

# Configures the endpoint
config :vk_bots, VkBots.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TTYUlOKa2aIEXLzDnJICBPsatODCywCzN5b27n0G+uwSkj7AXTH42x6CfbMC6ZU7",
  render_errors: [view: VkBots.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VkBots.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    vk: { Ueberauth.Strategy.VK, [default_scope: "email", profile_fields: "photo_200"] }
  ]

config :ueberauth, Ueberauth.Strategy.VK.OAuth,
  client_id: "5744471",
  client_secret: "qazqaz"

import_config "#{Mix.env}.exs"
