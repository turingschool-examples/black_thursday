require './lib/merchant_repository'
require './lib/sales_engine'
require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  

  def test_it_creates_merchant_objects
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    
    mr = se.merchants

    refute mr.all.empty?
  end

  def test_it_can_locate_merchant_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    mr = se.merchants
    result = mr.find_by_id(12334105)
    # binding.pry
    assert_equal "Shopin1901", result.name
  end

  def test_it_can_locate_merchant_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    mr = se.merchants  
    result = mr.find_by_name("Shopin1901")

    assert_equal 12334105, result.id
  end

  def test_it_can_locate_all_merchants_with_name_fragment
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    mr = se.merchants
    result = mr.find_all_by_name("SHOP")
    
# binding.pry
    assert_equal 12334105, result[0].id
    assert_equal "Shopin1901", result[0].name
  end
end