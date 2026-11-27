require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Settings read from environment variables (used by config/environments too)
require_relative "../lib/app_settings"

module WellInterventionGuide
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = ENV.fetch("APP_TIME_ZONE", "Asia/Jakarta")
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
