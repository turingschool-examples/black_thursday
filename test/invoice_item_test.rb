require_relative '../lib/invoice_item'
require_relative '../test/test_helper'

class InvoiceItemTest < Minitest::Test

  def setup
    @parent = mock("parent")
    @invoice_item = InvoiceItem.new({ :id         => 1,
                                     :item_id    => 263519844,
                                     :invoice_id => 2,
                                     :quantity   => 5,
                                     :unit_price => 1635,
                                     :created_at => "2012-03-27 14:54:09 UTC",
                                     :updated_at => "2012-03-27 14:58:12 UTC" },
                                     @parent)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_id
    assert_equal 1, @invoice_item.id
  end

  def test_it_has_invoice_id
    assert_equal 2, @invoice_item.invoice_id
  end

  def test_it_has_quantity
    assert_equal 5, @invoice_item.quantity
  end

  def test_it_has_a_unit_price
    assert_equal 16.35, @invoice_item.unit_price
  end

  def test_it_has_created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item.created_at
  end

  def test_it_has_updated_at
    assert_equal Time.parse("2012-03-27 14:58:12 UTC"), @invoice_item.updated_at
  end

end
