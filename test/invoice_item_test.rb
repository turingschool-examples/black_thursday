require "./test/test_helper"
require "./lib/invoice_item"

class InvoiceItemTest < Minitest::Test

  attr_reader :invoice_item

  def setup
    csv_hash = {:id => 6,
                :item_id => 7,
                :invoice_id => 8,
                :quantity => 1,
                :unit_price => BigDecimal.new(1099, 4),
                :created_at => "2016-01-11 09:34:06 UTC",
                :updated_at => "2007-06-04 21:35:10 UTC"
               }
    @invoice_item = InvoiceItem.new('fake_invoice_item_repository', csv_hash)
  end

  def test_Invoice_item_exists
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_invoice_item_has_id
    assert_equal 6, invoice_item.id
  end

  def test_invoice_item_has_item_id
    assert_equal 7, invoice_item.item_id
  end

  def test_invoice_item_has_invoice_id
    assert_equal 8, invoice_item.invoice_id
  end

  def test_invoice_item_has_quiantity
    assert_equal 1, invoice_item.quantity
  end

  def test_invoice_item_has_unit_price
    assert_equal BigDecimal.new(10.99,4), invoice_item.unit_price
  end

  def test_invoice_item_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice_item.created_at
  end

  def test_invoice_item_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, invoice_item.unit_price_to_dollars(BigDecimal.new(1099,4))
  end

end
