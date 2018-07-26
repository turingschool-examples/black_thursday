require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'time'
require 'pry'

class InvoiceItemTest < MiniTest::Test
  def setup
    @invoice_item = InvoiceItem.new({
                      :id          => 2345,
                      :item_id        => 263562118,
                      :invoice_id => 522,
                      :unit_price  => 847.87,
                      :quantity => 5,
                      :created_at  => "2012-03-27 14:54:35 UTC",
                      :updated_at  => "2012-03-27 14:54:35 UTC"
                    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_has_an_id_number
    assert_equal 2345, @invoice_item.id
  end

  def test_it_has_a_item_id
    assert_equal 263562118, @invoice_item.item_id
  end
  
  def test_it_has_a_invoice_id
    assert_equal 522, @invoice_item.invoice_id
  end

  def test_it_has_a_unit_price
    skip
    assert_equal 8.4700, @invoice_item.unit_price
  end

  def test_it_has_a_quantity
    assert_equal 5, @invoice_item.quantity
  end

  def test_it_has_a_created_time
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.created_at
  end

  def test_it_has_a_updated_time
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.updated_at
  end

end
