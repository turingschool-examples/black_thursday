require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item'

class ItemTest < Minitest::Test
	attr_reader :item
	def setup
		@item = Item.new({:id => "263395237".to_i, :name => "510+ RealPush Icon Set", :unit_price => BigDecimal.new("1200".to_i)/100,
		:created_at => Time.parse("2016-01-11 09:34:06 UTC"), :updated_at => Time.parse("2007-06-04 21:35:10 UTC"), :merchant_id => "12334141".to_i,
		:description => "Red balloons with streamers and party favors"}, nil)
	end

	def test_item_info_exists
		expected = {:id => "263395237".to_i, :name => "510+ RealPush Icon Set", :unit_price => BigDecimal.new("1200".to_i)/100,
		:created_at => Time.parse("2016-01-11 09:34:06 UTC"), :updated_at => Time.parse("2007-06-04 21:35:10 UTC"), :merchant_id => "12334141".to_i,
		:description => "Red balloons with streamers and party favors"}
		assert_equal expected, item.item_info
	end

	def test_item_instance_exists
		assert_nil item.ir_instance
	end

	def test_instance_of_item
		assert_equal Item, item.class
	end

	def test_item_has_a_name
		assert_equal '510+ RealPush Icon Set', item.name
	end

	def test_item_has_an_id
		assert_equal 263395237, item.id
	end
end
