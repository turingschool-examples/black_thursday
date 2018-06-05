require './test/test_helper.rb'
require './lib/invoice_item.rb'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new(
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal(1099, 4),
      created_at: '2016-01-11 11:51:36 UTC',
      updated_at: '2001-09-17 15:28:43 UTC'
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_you_can_access_specifications
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_equal 10.99, @ii.unit_price
    assert_equal Time.parse('2016-01-11 11:51:36 UTC'), @ii.created_at
    assert_equal Time.parse('2001-09-17 15:28:43 UTC'), @ii.updated_at
  end

  def test_change_unit_price_to_dollars
    refute_equal @ii.unit_price.inspect, '10.99'
    assert_equal @ii.unit_price_to_dollars.inspect, 10.99.inspect
  end
end
