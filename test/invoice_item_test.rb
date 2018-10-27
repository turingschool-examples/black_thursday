require_relative "./test_helper"

class InvoiceItemTest

  def setup
    @time = Time.now
    @invoice_item = InvoiceItem.new
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

# id - returns the integer id
  def test_it_has_id
    assert_equal 5, @invoice_item.id
  end
# item_id - returns the item id
  def test_it_has_item_id
    assert_equal 10, @invoice_item.item_id
  end
# invoice_id - returns the invoice id
  def test_it_has_invoice_id
    assert_equal 15, @invoice_item.invoice_id
  end
# quantity - returns the quantity
  def test_it_has_a_quantity
    assert_equal 20, @invoice_item.quantity
  end
# unit_price - returns the unit_price
  def test_it_has_unit_price
    assert_equal 25, @invoice_item.unit_price
  end
# created_at - returns a Time instance for the date the invoice item was first created
  def test_it_has_a_created_at_time
    assert_equal @time, @invoice_item.created_at
  end
# updated_at - returns a Time instance for the date the invoice item was last modified
  def test_it_has_an_updated_at_time
    assert_equal @time, @invoice_item.updated at
  end

end
