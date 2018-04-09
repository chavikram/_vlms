Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
#  config.action_controller.relative_url_root = '/vlms'
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  #Rails.logger = Logger.new(STDOUT)
  #config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
  config.cache_classes = false
  config.log_level = :error
  # Do not eager load code on boot.
  config.eager_load = false
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.cache_store = :dalli_store,nil,
   { :namespace => 'vlms', :expires_in => 1.day, :socket_timeout => 3, :compress => true }
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.assets.enabled = true
  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
   ActiveRecord::Base.logger = Logger.new(STDOUT)

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
