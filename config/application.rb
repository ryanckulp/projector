require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projector
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib') # adds Lib folder to autoloaded files
    config.autoload_paths += %W(#{config.root}/app/services)

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    # sendgrid
    ActionMailer::Base.smtp_settings = {
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :domain => 'ryanckulp.com',
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
    }

    config.active_record.raise_in_transactional_callbacks = true

    # disable superfluous generator extras
    config.generators do |g|
      g.assets = false # remove auto stylesheets
      g.helper = true
    end

  end
end
