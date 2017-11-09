require_relative 'test_helper'
require_relative "../lib/invoice_item"
require_relative "../lib/sales_engine"

class CustomerTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    iir = InvoiceItemRepository.new(se, "./data/invoice_items.csv")
    invoice_item = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, iir)

    assert_instance_of InvoiceItem, invoice_item
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

    iir = InvoiceItemRepository.new(se, "./data/invoice_items.csv")
    invoice_item = InvoiceItem.new({id: 1, item_id: 263519844, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, iir)

    assert_equal 1, invoice_item.id
    assert_equal 263519844, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
  end
end
