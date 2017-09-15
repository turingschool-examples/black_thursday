require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    @invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => "2012-03-27 14:54:35 UTC",
                                    :updated_at => "2012-03-27 14:54:35 UTC"
                                    },
                                    nil)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_an_id_value
    assert_equal 6, invoice_item.id
  end

  def test_it_has_an_item_id_value
    assert_equal 7, invoice_item.item_id
  end

  def test_it_has_an_invoice_id_value
    assert_equal 8, invoice_item.invoice_id
  end

  def test_it_has_a_quantity_value
    assert_equal 1, invoice_item.quantity
  end

  def test_it_has_a_unit_price_value
    assert_equal 10.99, invoice_item.unit_price
    assert_instance_of BigDecimal, invoice_item.unit_price
  end

  def test_it_has_a_created_at_value
    assert_instance_of Time, invoice_item.created_at
  end

  def test_it_has_a_updated_at_value
    assert_instance_of Time, invoice_item.updated_at
  end

  def test_it_has_a_parent_value
    assert_nil invoice_item.parent
  end
end
