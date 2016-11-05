require_relative './test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test


  def test_invoice_item_class_exists
    assert_instance_of InvoiceItem, InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end

end
