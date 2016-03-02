require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_a_merchant_is_creatable
    assert_equal Merchant, @merchant.class
  end

  def test_a_merchant_has_an_id
    assert_equal 5, @merchant.id
  end

  def test_a_merchant_has_a_name
    assert_equal "Turing School", @merchant.name
  end
end
