require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SurvivorV1
  class Application < Rails::Application
    # Expose our application's helpers to Administrate
    config.to_prepare do
      Administrate::ApplicationController.helper SurvivorV1::Application.helpers
    end
    config.active_job.queue_adapter = :sidekiq
    config.application_name = Rails.application.class.parent_name
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    console do
      Hirb.enable
    end
  end
end
