require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ReTimeline
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.load_defaults 6.0
    config.paths.add 'lib', eager_load: true

    config.generators do |g|
      g.assets false
      g.helper false
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
