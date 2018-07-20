require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant.rb'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new

  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

end
