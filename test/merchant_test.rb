require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

   def setup 
    @merchant_data = SalesEngine.from_csv("./data/merchants.csv")
    # binding.pry
   end

  def test_it_exists
    assert Merchant.new(@merchant_data)
  end

  def test_it_has_id_and_name
    merch = Merchant.new(@merchant_data)
    assert_equal 12334105, merch.id
    assert_equal "Shopin1901", merch.name
  end
  

end