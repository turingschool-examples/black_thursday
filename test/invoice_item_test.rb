require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(1099, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_id
    assert_equal 6, @ii.id
  end

  def test_it_has_item_id
    assert_equal 7, @ii.item_id
  end

  def test_it_has_invoice_id
    assert_equal 8, @ii.invoice_id
  end

  def test_it_can_get_quantity
    assert_equal 1, @ii.quantity
  end

  def test_it_has_unit_price
    assert_instance_of BigDecimal, @ii.unit_price
    assert_equal BigDecimal.new(10.99, 4), @ii.unit_price
  end

  def test_it_is_created_at
    assert_instance_of Time, @ii.created_at
  end

  def test_it_is_updated_at
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_converts_unit_price_to_dollars
    assert_equal 10.99, @ii.unit_price_to_dollars
  end

end
