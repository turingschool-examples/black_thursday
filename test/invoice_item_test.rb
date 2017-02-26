require './test/test_helper'
require './lib/invoice_item'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'

class InvoiceItemTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @ii = InvoiceItem.new({
      :id => "6",
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, @se.invoice_items)
  end

  def test_id_returns_integer_id
    assert_equal 6, @ii.id
  end

  def test_item_id_returns_item_id
    assert_equal 7, @ii.item_id
  end

  def test_invoice_id_returns_invoice_id
    assert_equal 8, @ii.invoice_id
  end

  def test_quantity_returns_quantity
    assert_equal 1, @ii.quantity
  end

  def test_unit_price_returns_unit_price
    assert_instance_of BigDecimal, @ii.unit_price
  end

  def test_created_at_is_time_object
    assert_instance_of Time, @ii.created_at
  end

  def test_updated_at_is_time_object
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_returns_unit_price_as_float
    assert @ii.unit_price_to_dollars.is_a?(Float)
  end
end
