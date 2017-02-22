require_relative'test_helper'
require'./lib/sales_engine'
require'./lib/merchant'

class SalesEngineTest < Minitest::Test
	attr_reader :se

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./data/items.csv",
			:merchants => "./test/fixtures/merchant_reduced.csv",
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

    assert_instance_of Merchant, merchant_1
		assert_equal "12337411", merchant_1.id
		assert_equal "CJsDecor", merchant_1.name
	end
end