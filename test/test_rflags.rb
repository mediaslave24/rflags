class TestRFlags < Minitest::Test
  Redis = ::Minitest::Mock.new
  Redis.expect(:class, 'Redis')

  class Flags
    extend RFlags

    flag :flag_a
    flag :flag_b => 'tmp/flag_b'
    flag :flag_c => [Redis, 'key']
    flag :flag_d => Pathname.new('tmp/flag_d')
  end

  def test_it_defines_flag_method
    assert Flags.respond_to?(:flag), 'Flags should have .flag method'
  end

  def test_it_defines_instance_variable_flag
    assert_instance_of RFlags::Flag, Flags.flag_a
  end

  def test_it_defines_file_flag
    assert_instance_of RFlags::FileFlag, Flags.flag_b
  end

  def test_it_defines_redis_flag
    assert_instance_of RFlags::RedisFlag, Flags.flag_c
  end

  def test_it_defines_file_flag_from_pathname
    assert_instance_of RFlags::FileFlag, Flags.flag_d
  end

  def test_resolve_exception
    error = assert_raises(TypeError) do
      Flags.flag wrong: Struct.new(:a)
    end
    assert_match(/but have Class/, error.message)
  end
end
