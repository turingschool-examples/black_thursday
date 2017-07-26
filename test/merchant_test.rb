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

  def test_it_can_find_items_by_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334112)

    assert_instance_of Item, merchant.items[0]
  end

end
