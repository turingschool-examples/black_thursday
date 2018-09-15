require_relative './test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item_1 = InvoiceItem.new({
      :id         => 1,
      :item_id    => 263519844,
      :invoice_id => 1,
      :quantity   => 5,
      :unit_price => BigDecimal.new("13635") / 100,
      :created_at => Time.parse("2012-03-27 14:54:09 UTC"),
      :updated_at => Time.parse("2012-03-27 14:54:09 UTC")
      })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item_1
  end

  def test_has_attributes
    assert_equal 1, @invoice_item_1.id
    assert_equal 263519844, @invoice_item_1.item_id
    assert_equal 1, @invoice_item_1.invoice_id
    assert_equal 5, @invoice_item_1.quantity
    assert_equal BigDecimal.new("136.35"), @invoice_item_1.unit_price
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item_1.created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item_1.updated_at
  end

  def test_can_return_unit_price_in_dollars
      assert_equal 136.35, @invoice_item_1.unit_price_to_dollars
  end

end
