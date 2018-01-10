require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'


class InvoicesTest < Minitest::Test

  def test_it_exists
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => "2012-01-07 15:15:22 -0700",
      :updated_at  => "2018-01-07 15:15:22 -0700",
    })

    assert_instance_of Invoice, invoice
  end

  def test_it_returns_items_by_id_in_invoice_items
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(641)
    items = invoice.items

    assert invoice.items.all? { |item| item.class == Item }
    assert_equal 1, items.count
    assert_equal 263445483, items[0].id
  end

  def test_it_returns_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert invoice.transactions.all? { |trans| trans.class == Transaction }
    assert_equal 2, invoice.transactions.count
  end

  def test_it_returns_customers_by_invoice_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })

    invoice = se.invoices.find_by_id(819)

    assert_instance_of Customer, invoice.customer
    assert_equal 819, invoice.id
  end

  def test_it_returns_merchant_by_invoice_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert_equal 12334633, invoice.merchant_id
  end

  def test_it_returns_success_for_is_paid_in_full
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert_equal 2, invoice.transactions.count
  end

  def test_it_returns_total_dollar_amount_for_invoice
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(641)

    assert_equal 0.429506e4, invoice.total
  end

end
