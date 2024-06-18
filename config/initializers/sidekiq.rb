require 'sidekiq'
require 'sidekiq-failures'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }

  config.server_middleware do |chain|
    chain.add Sidekiq::Failures::Middleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end
