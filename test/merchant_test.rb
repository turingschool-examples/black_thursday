require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test

  def test_if_create_class
    m = Merchant.new

    assert_instance_of Merchant, m
  end


end
