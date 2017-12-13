# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hello,
  ecto_repos: [Hello.Repo]

# Configures the endpoint
config :hello, HelloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GITrnwcPhM5AkxWau4FhqT/9cnCeZJ0rLx945JzirS+5fu3/9haylGep4pPVftG/",
  render_errors: [view: HelloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hello.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line

config :coherence,
  user_schema: Hello.Accounts.User,
  repo: Hello.Repo,
  module: Hello,
  web_module: HelloWeb,
  router: HelloWeb.Router,
  messages_backend: HelloWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  login_field: :username,
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, HelloWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
