require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    invoice = ({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})
    Invoice.new(invoice, [])
  end

  def test_it_exists
    assert_instance_of Invoice, setup
  end

  def test_merchant_id_is_correct_integer
    assert_equal 12337139, setup.merchant_id
  end

  def test_id_returns_correct_integer
    assert_equal 4, setup.id
  end

  def test_customer_id_is_correct_integer
    assert_equal 7, setup.customer_id
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
end
