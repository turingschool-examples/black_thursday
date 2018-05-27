require './test/test_helper.rb'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/merchant.rb'
require 'pry'

class MerchantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new("merchant")
    assert_instance_of Merchant, m
  end

  def test_it_has_a_merchant
    m = Merchant.new("merchant")
    assert_equal "merchant", m.merchant
  end

end
