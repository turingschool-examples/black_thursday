require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

  def set_up
    invoice_item_info = ({:id => "1", :item_id	=> "263519844",	:invoice_id => "1",	:quantity => "5",	:unit_price => "13635",	:created_at => "2012-03-27 14:54:09 UTC", :updated_at =>	"2012-03-27 14:54:09 UTC"})
    InvoiceItem.new(invoice_item_info, [])
  end

  def test_invoice_item_exists
    assert_instance_of InvoiceItem, set_up
  end

  def test_created_at_instance_of_time
    assert_instance_of Time, set_up.created_at
  end

  def test_updated_at_instance_of_time
    assert_instance_of Time, set_up.updated_at
  end

  def test_unit_price_instance_of_bigdecimal
    assert_instance_of BigDecimal, set_up.unit_price
  end

  def test_unit_to_dollar
    assert_equal 136.35, set_up.unit_to_dollar
  end

  def test_id
    assert_equal 1, set_up.id
  end

  def test_quantity
    assert_equal "5", set_up.quantity
  end

  def test_item_id
    assert_equal 263519844, set_up.item_id
  end

  def test_invoice_id
    assert_equal 1, set_up.invoice_id
  end

end
