require_relative './test_helper'

class InvoiceItemTest < Minitest::Test
  def test_it_exists
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :updated_at => Time.now,
    :created_at => Time.now
    })

    assert_instance_of InvoiceItem, ii
  end

  def test_it_has_attributes
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => 1099,
    :updated_at => "2017-01-11 12:29:33 UTC",
    :created_at => "2016-01-11 12:29:33 UTC"
    })

    assert_equal 6,ii.id
    assert_equal 7,ii.item_id
    assert_equal 8,ii.invoice_id
    assert_equal 1,ii.quantity
    assert_equal 10.99, ii.unit_price
    assert_equal Time.parse("2017-01-11 12:29:33 UTC"),ii.updated_at
    assert_equal Time.parse("2016-01-11 12:29:33 UTC"),ii.created_at
  end
end
