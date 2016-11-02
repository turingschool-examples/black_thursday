require './lib/merchant_repository'
require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  
  def setup 
    @merchant_data = SalesEngine.from_csv("./data/merchants.csv")
    # binding.pry
  end

  def test_it_creates_merchant_objects
    mr = MerchantRepository.new(@merchant_data)

    refute mr.all_merchants.empty?
  end

  def test_it_can_locate_merchant_by_id
    merchant = MerchantRepository.new(@merchant_data)
    result = merchant.find_by_id(12334105)

    assert_equal "Shopin1901", result.name
  end

  def test_it_can_locate_merchant_by_name
    merchant = MerchantRepository.new(@merchant_data)
    result = merchant.find_by_name("Shopin1901")

    assert_equal 12334105, result.id
  end

  def test_it_can_locate_all_merchants_with_name_fragment
    merchant = MerchantRepository.new(@merchant_data)
    result = merchant.find_all_by_name("SHOP")
    assert_equal 12334105, result[0].id
    assert_equal "Shopin1901", result[0].name
  end
end