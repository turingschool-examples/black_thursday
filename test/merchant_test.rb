require './test/test_helper'
require './lib/merchant'
# require './lib/sales_engine'

class MerchantTest < Minitest::Test
  # def setup
  #   @se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./test/testdata/merchants_simple.csv",
  #   })
  # end

  def test_we_can_instantiate_merchant_with_name
    m = Merchant.new({:name => "Gary"})
    assert_equal "Gary", m.name
  end

  def test_we_can_instantiate_merchant_with_different_name
    m = Merchant.new({:name => "Joe"})
    assert_equal "Joe", m.name
  end

  def test_we_can_instantiate_merchant_with_id
    m = Merchant.new({:id => 12345})
    assert_equal 12345, m.id
  end

  def test_we_can_instantiate_merchant_with_different_id
    m = Merchant.new({:id => 54321})
    assert_equal 54321, m.id
  end

  def test_we_can_instantiate_merchant_with_name_and_id
    m = Merchant.new({:name => "Pamela", :id => 90210})
    assert_equal "Pamela", m.name
    assert_equal 90210, m.id
  end

  def test_items_method_returns_merchant_items_length
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant = se.merchants.find_by_id(12334132)
    assert_equal 3, merchant.items.length
  end

  def test_items_method_returns_different_merchant_items_length
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant = se.merchants.find_by_id(12334189)
    assert_equal 2, merchant.items.length
  end
end
