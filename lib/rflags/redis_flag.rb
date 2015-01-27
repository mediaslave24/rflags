module RFlags
  class RedisFlag
    attr_reader :key, :redis

    def initialize(redis, key)
      @redis = redis
      @key = key
    end

    def set?
      !redis.get(key).nil?
    end

    def set
      redis.set(key, '')
    end

    def reset
      redis.del(key)
    end
  end
end
