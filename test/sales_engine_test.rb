require_relative'test_helper'
require'./lib/sales_engine'
require'./lib/merchant'

class SalesEngineTest < Minitest::Test
	attr_reader :se

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./data/items.csv",
			:merchants => "./data/merchants.csv",
		})
	end

  def test_hash_of_pathnames_can_be_passed_into_sales_engine
		ir = se.items
		mr = se.merchants
    assert_instance_of ItemRepository, ir
    assert_instance_of MerchantRepository, mr
  end

	def test_merchants_can_find_by_name_from_sales_engine
    mr = se.merchants
    merchant_1 = mr.find_by_name("CJsDecor")
    merchant_2 = mr.find_by_name("NOT A NAME")

    assert_equal "CJsDecor", merchant_1[:name]
    assert_nil merchant_2
	end
end