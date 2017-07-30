require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_exists
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_invoice_item_has_id
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    id = invoice_item.id

    assert_equal 15, invoice_item.id
  end

end
