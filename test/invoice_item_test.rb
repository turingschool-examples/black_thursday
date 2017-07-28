require_relative 'test_helper'
require './lib/invoice_item'
require 'pry'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => 1300,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      })
  end

  def test_it_exist
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_returns_id
    assert_equal 6, @ii.id
  end

  def test_it_returns_item_id
    assert_equal 7, @ii.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 8, @ii.invoice_id
  end

  def test_it_returns_quantity
    assert_equal 1, @ii.quantity
  end

  def test_it_returns_unit_price
    assert_equal 13.00, @ii.unit_price
  end

end
