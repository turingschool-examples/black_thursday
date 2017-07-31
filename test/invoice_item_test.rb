require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :ii

  def setup
    @ii = InvoiceItem.new({:id => 6,
                           :item_id => 7,
                           :invoice_id => 8,
                           :quantity => 1,
                           :unit_price => 1099,
                           :created_at => Time.now,
                           :updated_at => Time.now
                          })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, ii
  end

  def test_it_returns_id
    assert_equal 6, ii.id
  end

  def test_it_returns_item_id
    assert_equal 7, ii.item_id
  end

  def test_it_returns_knows_its_quantity
    assert_equal 1, ii.quantity
  end

  def test_it_returns_unit_price
    assert_equal 10.99, ii.unit_price
  end

  def test_it_knows_it_birth_day
    assert_instance_of Time, ii.created_at
  end

  def test_it_know_updated_date
    assert_instance_of Time, ii.updated_at
  end
end
