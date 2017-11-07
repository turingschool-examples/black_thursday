require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    invoice = ({:id => "4", :customer_id => "1", :merchant_id => "12334269",
      :status => "pending", :created_at => "2013-08-05",
      :updated_at => "2014-06-06"})
    Invoice.new(invoice, [])
  end

  def test_it_exists
    assert_instance_of Invoice, setup
  end

  def test_merchant_id_is_correct_integer
    assert_equal 12334269, setup.merchant_id
  end

  def test_id_returns_correct_integer
    assert_equal 4, setup.id
  end

  def test_customer_id_is_correct_integer
    assert_equal 1, setup.customer_id
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end

  def test_invoice_is_paid_in_full
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files).invoices

    assert_equal true, se.invoices.first.is_paid_in_full?
  end

  def test_returns_the_total_amount_of_the_invoice
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)
    invoice = se.invoices.find_by_id(5)

    assert_equal 0.1582816e5, invoice.total
  end
end
