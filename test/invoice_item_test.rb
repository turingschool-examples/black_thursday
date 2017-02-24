require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
  })
  end

  def test_invoice_item_exists
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_equal 0.1099e2, @ii.unit_price
    assert @ii.created_at
    assert @ii.updated_at
  end

end
