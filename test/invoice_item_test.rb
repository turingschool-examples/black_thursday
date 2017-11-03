require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140", :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_instance_of InvoiceItem, inv_item
  end

  def test_id_returns_correct_integer
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140", :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_equal 5, inv_item.id
  end

  def test_item_id_is_correct_integer
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_equal 263515158, inv_item.item_id
  end

  def test_invoice_id_returns_correct_integer
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_equal 1, inv_item.invoice_id
  end

  def test_quantity_returns_correct_integer
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_equal 7, inv_item.quantity
  end

  def test_unit_price_returns_correct_price
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_equal 263515158, inv_item.item_id
  end

  def test_time_returns_time_exists
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_instance_of Time, inv_item.created_at
    assert_instance_of Time, inv_item.updated_at
  end

end
