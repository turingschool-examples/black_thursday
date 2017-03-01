require_relative'test_helper'
require'./lib/invoice_item'

class InvoiceItemTest < Minitest::Test
	attr_reader :ii
	def setup
		@ii = InvoiceItem.new({
			:id => 6,
			:item_id => 7,
			:invoice_id => 8,
			:quantity => 1,
			:unit_price => BigDecimal.new(10.99, 4),
			:created_at => Time.now.to_s,
			:updated_at => Time.now.to_s
		}, nil)
	end

	def test_all
		assert_equal 6, ii.id
		assert_equal 7, ii.item_id
		assert_equal 8, ii.invoice_id
		assert_equal 1, ii.quantity
		assert_equal 0, ii.unit_price.to_i
		assert_instance_of Time, ii.created_at 
		assert_instance_of Time, ii.updated_at
	end

end