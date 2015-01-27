class TestFileFlag < Minitest::Test
  def setup
    @flag = RFlags::FileFlag.new('tmp/file_flag')
    FileUtils.rm_f('tmp/file_flag')
  end

  def teardown
    FileUtils.rm_f('tmp/file_flag')
  end

  include FlagAssetions
end
