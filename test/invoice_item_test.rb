require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

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




end
