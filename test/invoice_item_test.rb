require_relative "./test_helper"

class InvoiceItemTest<Minitest::Test

  def setup
    @time = Time.now
    stats = {
      id:"5",
      item_id:"10",
      invoice_id:"15",
      quantity:"20",
      unit_price:"25",
      created_at:@time,
      updated_at:@time
    }
    @invoice_item = InvoiceItem.new(stats)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_id
    assert_equal 5, @invoice_item.id
  end

  def test_it_has_item_id
    assert_equal 10, @invoice_item.item_id
  end

  def test_it_has_invoice_id
    assert_equal 15, @invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal 20, @invoice_item.quantity
  end

  def test_it_has_unit_price
    assert_instance_of BigDecimal, @invoice_item.unit_price
  end

  def test_it_has_a_created_at_time
    assert_equal @time.to_s, @invoice_item.created_at.to_s
  end

  def test_it_has_an_updated_at_time
    assert_equal @time.to_s, @invoice_item.updated_at.to_s
  end

end
