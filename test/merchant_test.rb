require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/merchant.rb'


class MerchantTest < Minitest::Test


  attr_reader :merchant
  def setup
    @merchant = Merchant.new
  end

  def test_it_exists
    assert merchant
  end

  def test_has_some_merchants
    assert merchant.merchants
  end

end
