require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantTest< MiniTest::Test
  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => 'Turing School'}, nil)

    assert_instance_of Merchant, merchant
  end

  def test_merchant_can_have_name_and_id
    merchant = Merchant.new({:id => 5, :name => 'Turing School'}, nil)

    assert_equal 'Turing School', merchant.name
    assert_equal 5, merchant.id
  end

  def test_merchant_can_have_name_and_id_for_another_merchant
    merchant = Merchant.new({:id => 3, :name => 'Walmart'}, nil)

    assert_equal 'Walmart', merchant.name
    assert_equal 3, merchant.id
  end
end
