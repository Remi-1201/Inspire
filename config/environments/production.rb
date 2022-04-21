Rails.application.configure do

  config.cache_classes = true


  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true


  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = true

  config.active_storage.service = :amazon

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  # config.cache_store = :mem_cache_store

  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "Inspire_production"

  config.action_mailer.perform_caching = false

  # config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
