require 'redis'
redis_config = Rails.configuration.redis
Redis.current = Redis.new(host: redis_config['host'], port: redis_config['port'].to_i)