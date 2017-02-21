require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant"
require "simplecov"

SimpleCov.start

class MerchantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new
    assert_instance_of Merchant, m
  end

end

