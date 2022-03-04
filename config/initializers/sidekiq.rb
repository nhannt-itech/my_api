Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server { |config| config.redis = { url: "redis://#{ENV['REDIS_SERVER']}:6379" } }

Sidekiq.configure_client { |config| config.redis = { url: "redis://#{ENV['REDIS_SERVER']}:6379" } }
