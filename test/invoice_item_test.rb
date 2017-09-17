require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require 'pry'

class InvoiceItemTest < MiniTest::Test
  attr_reader :ii

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
    assert_instance_of InvoiceItem, ii
  end

  def test_initializes_with_id
    assert_equal 6, ii.id
  end

  def test_initalize_with_item_id
    assert_equal 7, ii.item_id
  end

  def test_initialize_with_invoice_id
    assert_equal 8, ii.invoice_id
  end

  def test_initialize_with_quantity
    assert_equal 1, ii.quantity
  end

  def test_initialize_with_unit_price
    assert_instance_of BigDecimal, ii.unit_price
  end

  def test_initializes_with_created_time
    assert_instance_of Time, ii.created_at
  end

  def test_initializes_with_updated_time

    assert_instance_of Time, ii.updated_at
  end

end
