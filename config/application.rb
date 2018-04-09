require File.expand_path('../boot', __FILE__)
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thikkaro
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

#    config.relative_url_root = '/vlms'
 #   config.assets.prefix = '/vlms'
    config.records_per_page = 10
    config.assets.enabled = true
    #config.assets.digest = true
    config.time_zone = 'Kolkata'

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
#    config.assets.precompile = config.assets.precompile + %w(*.png *.jpg *.jpeg *.gif *.woff *.ttf *.svg *.eot)
    config.assets.paths << "#{Rails}/vendor/assets/fonts"    
     config.action_view.field_error_proc = Proc.new { |html_tag, instance|
         if html_tag =~ /\<label/
           html_tag
         else
           errors = Array(instance.error_message).join(',')
           %(<div class=\"field_with_errors\">#{html_tag}<span class="validation-error">&nbsp;#{errors}</span></div>).html_safe
         end
       }
     end
end
