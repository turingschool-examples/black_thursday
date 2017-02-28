require './test/test_helper'

class InvoiceItemTest < Minitest::Test

  attr_reader :se, :invoice_item_1

  def setup
      @invoice_item_1 = InvoiceItem.new(id:"1", item_id:"263519844", invoice_id:"1", quantity:"5", unit_price:"13635", created_at:"2012-03-27 14:54:09 UTC", updated_at:"2012-03-27 14:54:09 UTC")
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item_1
  end

  def test_it_has_id
    assert_equal 1, invoice_item_1.id
  end

  def test_it_has_item_id
    assert_equal 263519844, invoice_item_1.item_id
  end

  def test_it_has_invoice_id
    assert_equal 1, invoice_item_1.invoice_id
  end

  def test_it_has_a_quantitiy
    assert_equal 5, invoice_item_1.quantity
  end

  def test_it_has_unit_price
    assert_instance_of BigDecimal, invoice_item_1.unit_price
    assert_equal 136.35, invoice_item_1.unit_price.to_f
  end

  def test_created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item_1.created_at
  end

  def test_updated_time
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item_1.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 136.35, invoice_item_1.unit_price_to_dollars
  end

end
