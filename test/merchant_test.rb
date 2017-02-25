require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./data/items_test_data.csv",
  :merchants => "./data/merchants.csv",})
  end

  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_merchant_id
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_merchant_name
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end

  def test_find_items_by_merchant_id
    merchant = @se.merchants.find_by_id(12334783)

    assert_instance_of Array, merchant.items
    assert_equal 2, merchant.items.count
    assert_equal "Freedom", merchant.items.first.name
  end

end
