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

  def test_it_returns_items_by_merchant_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      merchants: "./test/fixtures/merchants_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(641)

    assert invoice.items.all? { |item| item.class == Item }
    assert_equal 1, invoice.items.count
  end

  def test_it_returns_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert invoice.transactions.all? { |trans| trans.class == Transaction }
    assert_equal 2, invoice.transactions(2179).count
  end

  def test_it_returns_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(819)

    assert_instance_of Customer, invoice.customer
<<<<<<< HEAD
    assert_equal 1, invoice.customer.count
=======
>>>>>>> 315a23ee28b77ef5893d669b98c687ab9d39faa8
  end

end
