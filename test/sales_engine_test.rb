require_relative'test_helper'
require'./lib/sales_engine'

class SalesEngineTest < Minitest::Test
	attr_reader :se

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./data/items.csv",
			:merchants => "./data/merchants.csv",
		})
	end

	def test_find_by_name
		mr = se.merchants
		merchant = mr.find_by_name("CJsDecor")
		assert_equal 12337411, merchant
	end
end