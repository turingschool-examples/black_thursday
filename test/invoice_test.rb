require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require 'minitest/autorun'
require 'minitest/pride'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
    @invoice = @engine.invoices.find_by_id(3452)
  end

  def test_it_exists
    assert_instance_of Invoice, @engine.invoices.invoices.first
  end

  def test_id_returns_the_invoice_id
    assert_equal 3452, @invoice.id
  end

  def test_customer_id_returns_the_invoice_customer_id
    assert_equal 679, @invoice.customer_id
  end

  def test_merchant_id_returns_the_invoice_merchant_id
    assert_equal 12335690, @invoice.merchant_id
  end

  def test_status_returns_the_invoice_status
    assert_equal :pending, @invoice.status
  end

  def test_create_at_returns_a_time_instance_for_the_created_at_date
    assert_equal Time.parse("2015-07-10 00:00:00 -0600"), @invoice.created_at
  end

  def test_updated_at_returns_a_time_instance_for_last_time_invoice_was_updated
    assert_equal Time.parse("2015-12-10 00:00:00 -0700"), @invoice.updated_at
  end

end
