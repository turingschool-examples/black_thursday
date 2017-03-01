require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'

class InvoiceItemTest < Minitest::Test
  attr_reader :ii
  def setup
    @ii = InvoiceItem.new({
        :id => 2,
        :item_id => 12334122,
        :invoice_id => 1,
        :quantity => 3,
        :unit_price => "1099",
        :created_at => "2012-03-27 14:54:09 UTC",
        :updated_at => "2012-03-27 14:54:09 UTC"
        }, "invoiceitemrepo")
  end

  def test_it_exists
    assert_instance_of InvoiceItem, ii
  end

  def test_it_knows_id
    assert_equal 2, ii.id
  end

  def test_it_knows_item_id
    assert_equal 12334122, ii.item_id
  end

  def test_it_knows_invoice_id
    assert_equal 1, ii.invoice_id
  end

  def test_it_knows_quantity
    assert_equal 3, ii.quantity
  end

  def test_it_knows_unit_price
    assert_instance_of BigDecimal, ii.unit_price
    assert_equal 10.99, ii.unit_price
  end

  def test_it_knows_when_it_was_created
    assert_instance_of Time, ii.created_at
    assert_equal 2012, ii.created_at.year
  end

  def test_it_knows_when_it_was_last_updated
    assert_instance_of Time, ii.updated_at
    assert_equal 03, ii.updated_at.month
  end

  def test_it_knows_its_item_repo
    assert_equal "invoiceitemrepo", ii.invoice_item_repo
  end

  def test_it_can_convert_unit_price_to_dollars
    assert_equal 10.99, ii.unit_price_to_dollars
  end

end
