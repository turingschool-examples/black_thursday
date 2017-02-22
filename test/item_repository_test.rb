require_relative'test_helper'
require'./lib/sales_engine'
require'./lib/item_repository'
	
class ItemTest < Minitest::Test
		attr_reader :ir, :se

	def setup
		@se = SalesEngine.from_csv({
  				:items     => "./test/fixtures/items_reduced.csv",
  				:merchants => "./data/merchants.csv"
					})
		@ir = se.items
	end

	def test_can_find_all
		assert_equal 2, ir.all.count
	end

	def test_can_find_by_name
		assert_instance_of Items, ir.find_by_name("Item Repellat Dolorum")
	end

	def test_can_find_by_id
		assert_instance_of Items, ir.find_by_id("263395617")
	end
end