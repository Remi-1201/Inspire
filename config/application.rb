require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Inspire
  class Application < Rails::Application
    config.action_controller.default_protect_from_forgery = false
    config.load_defaults 6.0
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local    
    config.i18n.default_locale = :en

    config.generators do |g|
      g.test_framework :rspec,
                       model_specs: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
    end
  end
end
require "active_storage/attached"
 