require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_class_merchant_exists
    merchant = Merchant.new({:id => 5, :name => "turing school"})

    assert_instance_of Merchant, merchant
  end

  def test_merchant_initializes_with_id_and_name
    merchant = Merchant.new({:id => 5, :name => "turing school"})

    assert_equal 5, merchant.id
    assert_equal "turing school", merchant.name
  end
end
