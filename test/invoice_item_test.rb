require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new({
                    :id => 6,
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal.new(10.99, 4),
                    :created_at => Time.now,
                    :updated_at => Time.now
                  })
  end    
  
  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end
  
  def test_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id
    assert_equal 1, @invoice_item.quantity
    assert_instance_of BigDecimal, @invoice_item.unit_price
    assert_instance_of Time, @invoice_item.created_at
    assert_instance_of Time, @invoice_item.updated_at
  end
  
  def test_it_converst_unit_price_to_dollars
    assert_equal 0.1, @invoice_item.unit_price_to_dollars
  end
            
end                  
          