require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'minitest/autorun'
require 'minitest/test'
require 'minitest/mock'

module FlagAssetions
  def test_it_is_unset_by_default
    assert_equal false, @flag.set?
  end

  def test_it_can_be_set
    assert_equal false, @flag.set?
    @flag.set
    assert_equal true, @flag.set?
  end

  def test_it_can_be_reset
    @flag.set
    assert_equal true, @flag.set?
    @flag.reset
    assert_equal false, @flag.set?
  end
end
