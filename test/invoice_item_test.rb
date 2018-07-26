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

  def test_it_has_id
    assert_equal 6, @invoice_item.id 
  end


end
