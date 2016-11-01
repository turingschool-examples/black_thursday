require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './fixtures/sales_engine_mock'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

 
  def merchant_data
    @merchant_data = CSV.open './fixtures/merchant_single.csv', headers: true, header_converters: :symbol
  end

  def test_it_creates_merchant_objects
    parent = Minitest::Mock.new
    merchant = MerchantRepository.new(merchant_data, parent)

    refute merchant.all.empty?
  end

  def test_it_can_locate_merchant_by_id
    parent = Minitest::Mock.new
    merchant = MerchantRepository.new(merchant_data, parent)
    result = merchant.find_by_id("12334105")

    assert result["name"].include?("Shopin1901")
  end

  def test_it_can_locate_merchant_by_name
    parent = Minitest::Mock.new
    merchant = MerchantRepository.new(merchant_data, parent)
    result = merchant.find_by_name("Shopin1901")
# binding.pry
    assert result["id"].include?("12334105")
  end

  def test_it_can_locate_all_merchants_with_name_fragment
    parent = Minitest::Mock.new
    merchant = MerchantRepository.new(merchant_data, parent)
    result = merchant.find_all_by_name("SHOP")
binding.pry
    assert result[0]["id"] == "12334105"
    assert result[0]["name"] == "Shopin1901"
  end
end