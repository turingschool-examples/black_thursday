require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  attr_reader :ii

  def setup
    @ii = InvoiceItem.new(
    { :id => "1",
      :item_id => "263519844",
      :invoice_id => "1",
      :quantity => "5",
      :unit_price => BigDecimal.new(13.63, 4),
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-28 15:54:09 UTC"
    })
  end

  def test_it_can_return_an_id
    assert_equal 1, ii.id
  end

  def test_it_can_return_an_item_id
    assert_equal 263519844, ii.item_id
  end

  def test_it_can_return_quantity
    assert_equal "5", ii.quantity
  end

  def test_it_can_return_unit_price
    assert_equal 13.63, ii.unit_price.to_f*100
  end

  def test_it_can_return_when_it_was_created
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), ii.created_at
  end

  def test_it_can_return_when_it_was_updated
    assert_equal Time.parse("2012-03-28 15:54:09 UTC"), ii.updated_at
  end

  def test_it_can_be_inspected
    assert_equal "#<InvoiceItem", ii.inspect
  end

end
