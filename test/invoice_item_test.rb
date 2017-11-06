require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    inv_item = ({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140", :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})
    InvoiceItem.new(inv_item, [])
  end

  def test_it_exists
    assert_instance_of InvoiceItem, setup
  end

  def test_id_returns_correct_integer
    assert_equal 5, setup.id
  end

  def test_item_id_is_correct_integer
    assert_equal 263515158, setup.item_id
  end

  def test_invoice_id_returns_correct_integer
    assert_equal 1, setup.invoice_id
  end

  def test_quantity_returns_correct_integer
    assert_equal 7, setup.quantity
  end

  def test_unit_price_returns_correct_price
    assert_equal 263515158, setup.item_id
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end

end
