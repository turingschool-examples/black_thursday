require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test 
	attr_reader :se, :ir
	def setup
		@se = SalesEngine.from_csv({
  	:items     => "./data/items.csv",
  	:merchants => "./data/merchants.csv",
		})
		@ir = se.items
	end

	def test_it_exists
		assert_equal ItemRepository, ir.class
	end

	def test_items_hash_populates
		refute ir.items.empty?
	end

	def test_all_method_returns_array_of_all_items
		assert_equal 1367, ir.all.count
		assert_equal Array, ir.all.class
	end

	def test_find_by_id	
		assert_equal Item, ir.find_by_id(263395237).class
		assert_nil ir.find_by_id('aardwolf')
	end

	def test_find_by_name
		assert_equal Item, ir.find_by_name("510+ RealPush Icon Set").class
	end

	def test_it_can_find_fragment_descriptions
		expected = ["TYPE 03 CORNER BORDER ART CRAFT PATTERN DESIGN PLASTIC DRAWING STENCIL TEMPLATE", "USA AMERICAN FLAG EMBROIDERED IRON- ON PATCH 2.5X4&QUOT; WHITE BORDER APPLIQUE"]
		result = ir.find_all_with_description('border')
		assert_equal Array, result.class
		assert_equal expected, result 
	end

	def test_it_can_find_all_by_price
		se_1 = SalesEngine.from_csv({
  	:items     => "./test/fixtures/item_fixtures.csv",
  	:merchants => "./data/merchants.csv",
		})
		ir_1 = se.items

		result = ir_1.find_all_by_price('1200')
		# assert_equal ['1200'], result
		assert_equal Array, result.class
		assert_equal Item, result[0].class
		assert_equal false, result.any? { |item| item.unit_price != '1200' }
	end
end