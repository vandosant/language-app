require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LanguageApp
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.enabled = true
    config.assets.precompile += %w( *.css *.js *.scss )
  end
end
