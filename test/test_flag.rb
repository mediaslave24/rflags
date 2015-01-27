class TestFlag < Minitest::Test
  def setup
    @flag = RFlags::Flag.new
  end

  include FlagAssetions
end
