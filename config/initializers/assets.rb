# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.enabled = true
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.initialize_on_precompile = true
Rails.application.config.assets.precompile += %w( vip_references.js )
Rails.application.config.assets.precompile += %w( simple-sidebar.css )
Rails.application.config.assets.precompile += %w( highcharts-custom.js )
Rails.application.config.assets.precompile += %w( jsapi.js )
Rails.application.config.assets.precompile += %w( print.css )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
