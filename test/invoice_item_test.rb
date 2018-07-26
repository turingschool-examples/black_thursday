require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    invoice_item = InvoiceItem.new({
                :id => 6,
                :item_id => 7,
                :invoice_id => 8,
                :quantity => 1,
                :unit_price => BigDecimal.new(10.99, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })

    assert_instance_of InvoiceItem, invoice_item
  end

end
