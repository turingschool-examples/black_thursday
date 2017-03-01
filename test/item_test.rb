require_relative'test_helper'
require'./lib/item'
require'bigdecimal'

class ItemTest < Minitest::Test
	attr_reader :i

	def setup
		@i = Item.new({
			:name        => "Pencil",
			:description => "You can use it to write things",
			:unit_price  => BigDecimal.new(10.99,4),
			:created_at  => "2017-02-27",
			:updated_at  => "2017-02-27",
			}, nil)
	end

	def test_can_make_new_merchant
		assert_instance_of Item, i
		assert_equal "Pencil", i.name
		assert_equal "You can use it to write things", i.description
		assert_equal 0.1, i.unit_price.to_f
	end

	def test_can_change_to_dollars
		assert_equal 0.1, i.unit_price_to_dollars
	end
end