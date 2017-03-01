require './test/test_helper'
require './lib/invoice'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @iv = Invoice.new({
      :id          => 397,
      :customer_id => 79,
      :merchant_id => 12334284,
      :status      => "shipped",
      :created_at  => "2003-09-10",
      :updated_at  => "2014-03-13"
      })
  end

  def test_assert_it_exists
    assert_instance_of Invoice, @iv
  end

  def test_it_returns_integer_id_of_invoice
    assert_equal 397, @iv.id
  end

  def test_it_returns_customer_id_of_invoice
    assert_equal 79, @iv.customer_id
  end

  def test_it_returns_merchant_id_of_invoice
    assert_equal 12334284, @iv.merchant_id
  end

  def test_it_returns_status_of_invoice
    assert_equal :shipped, @iv.status
  end

  def test_it_returns_instance_of_time_for_date_invoice_was_first_created
    assert_instance_of Time, @iv.created_at
  end

  def test_it_returns_instance_of_time_for_date_invoice_was_last_modified
    assert_instance_of Time, @iv.updated_at
  end
end
