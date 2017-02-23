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
		assert_equal "510+ RealPush Icon Set", ir.find_by_name("510+ RealPush Icon Set").name
	end

	def test_can_find_by_id
		assert_equal "263395617", ir.find_by_id("263395617").id
	end

	def test_can_give_info_on_item
		item_1 = ir.find_by_name("510+ RealPush Icon Set")

		assert_equal "510+ RealPush Icon Set", item_1.name
		assert_equal "263395237", item_1.id
		assert_equal "12334141", item_1.merchant_id
	end

	def test_item_2
		item_2 = ir.find_by_name("Glitter scrabble frames")

		assert_equal "Glitter scrabble frames", item_2.name
		assert_equal "263395617", item_2.id
		assert_equal "12334185", item_2.merchant_id
	end
end