require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test

  def test_it_exists
  merchant = Merchant.new({:id => 12334105, :name => 'Shopin1901'})

  assert_instance_of Merchant, merchant
  end

  def test_can_retrieve_name
    merchant = Merchant.new({:id => 12334105, :name => 'Shopin1901'})

    assert_equal 'Shopin1901', merchant.name
  end

  def test_it_can_retrieve_id
    merchant = Merchant.new({:id => 12334105, :name => 'Shopin1901'})

    assert_equal 12334105, merchant.id
  end


end
