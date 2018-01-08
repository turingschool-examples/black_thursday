require_relative "test_helper"
require_relative "../lib/invoice_item"
require_relative "../lib/sales_engine"

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ii = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27", updated_at: "2012-03-27"}, se)

    assert_instance_of InvoiceItem, ii
  end

  def test_it_has_attributes
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ii = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27", updated_at: "2012-03-27"}, se)

    assert_equal 1, ii.id
    assert_equal 263519844, ii.item_id
    assert_equal 1, ii.invoice_id
    assert_equal 5, ii.quantity
    assert_equal 0.13635e3, ii.unit_price
    assert_instance_of Time, ii.created_at
    assert_equal "2012-03-27 00:00:00 -0600", ii.created_at.to_s
    assert_instance_of Time, ii.updated_at
    assert_equal "2012-03-27 00:00:00 -0600", ii.updated_at.to_s
  end

  def test_unit_price_to_dollars_converts_to_dollars
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ii = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27", updated_at: "2012-03-27"}, se)

    assert_equal 136.35, ii.unit_price_to_dollars
  end

  def test_item_returns_item_of_invoice_item
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ii = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27", updated_at: "2012-03-27"}, se)

    assert_instance_of Item, ii.item
    assert_equal 263519844, ii.item.id
  end
end
