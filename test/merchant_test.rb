require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exist
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_instance_of Merchant, m
  end

  def test_return_name
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_equal "Chuck", m.name
  end
  
  def test_return_id
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_equal 9999, m.id
  end

  def test_item_method_return_array_of_items
    se =SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv" })
    mr = se.merchants
    merchant = mr.all[0]
    item = merchant.items[0]
    assert_instance_of Array, merchant.items
    refute merchant.items.empty?
    assert_equal "510+ RealPush Icon Set",item.name
  end
end