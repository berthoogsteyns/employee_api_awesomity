# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :employee_management_api,
  ecto_repos: [EmployeeManagementApi.Repo]

# Configures the endpoint
config :employee_management_api, EmployeeManagementApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CgvCIza4mtnlqDrjh+TVeV35MtkLLKqgJbZVaBQdnh73NozbpBTSn8jSZR+z88Ha",
  render_errors: [view: EmployeeManagementApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EmployeeManagementApi.PubSub,
  live_view: [signing_salt: "zmD+ZZoV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
