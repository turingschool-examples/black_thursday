require_relative '../lib/invoice_item'
require_relative './test_helper'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = InvoiceItem.new(
      {
        id: 1,
        item_id: 263519844,
        invoice_id: 1,
        quantity: 5,
        unit_price: 13635,
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'
      }
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

end
