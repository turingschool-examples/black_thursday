require './test/test_helper'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    @invoice_item = InvoiceItem.new( {
      :id         => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => 1099,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"},
      parent = ""
    )
  end

  def test_it_has_an_id
    assert_equal 6, invoice_item.id
  end

  def test_it_has_an_item_id
    assert_equal 7, invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal 1, invoice_item.quantity
  end

  def test_it_has_a_created_at
    assert_instance_of Time, invoice_item.created_at
  end

  def test_it_has_a_updated_at
    assert_instance_of Time, invoice_item.updated_at
  end

  def test_it_the_unit_price
    assert_instance_of BigDecimal, invoice_item.unit_price
  end

  def test_it_converts_unit_price_to_dollars
    assert_equal 10.99, invoice_item.unit_price_to_dollars * 100
  end

end
