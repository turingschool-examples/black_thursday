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
		assert ir.items.empty?
		ir.item_maker
		refute ir.items.empty?
	end

	def test_all_method_returns_array_of_all_items
		ir.item_maker
		assert_equal 1367, ir.all.count
		assert_equal Array, ir.all.class
	end

	def test_find_by_id	
		ir.item_maker
		assert_equal Item, ir.find_by_id(263395237).class
		assert_nil ir.find_by_id('aardwolf')
	end

	def test_find_by_name
		ir.item_maker
		assert_equal Item, ir.find_by_name("510+ RealPush Icon Set").class
	end

	def test_it_can_find_fragment_descriptions
		ir.item_maker
		expected = ["TYPE 03 CORNER BORDER ART CRAFT PATTERN DESIGN PLASTIC DRAWING STENCIL TEMPLATE", "USA AMERICAN FLAG EMBROIDERED IRON- ON PATCH 2.5X4&QUOT; WHITE BORDER APPLIQUE"]
		result = ir.find_all_with_description('border')
		assert_equal Array, result.class
		assert_equal expected, result 
	end





end