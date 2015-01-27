class TestRedisFlag < Minitest::Test
  class RedisMock
    def initialize
      @store = {}
    end

    def get(key)
      @store[key]
    end

    def set(key, val)
      @store[key] = val
    end

    def del(key)
      @store.delete(key)
    end
  end

  def setup
    @flag = RFlags::RedisFlag.new(RedisMock.new, 'key')
  end

  include FlagAssetions
end
