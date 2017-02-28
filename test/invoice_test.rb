require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @i = @se.invoices
  end

  def test_invoice_exists
    assert_equal 1, @i.all.first.id
    assert_equal 1, @i.all.first.customer_id
    assert_equal 12335938, @i.all.first.merchant_id
    assert_equal :pending, @i.all.first.status
  end

  def test_invoice_has_attached_merchant
    invoice = @i.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
  end

  def test_invoices_have_attached_items
    invoice = @i.find_by_id(20)

    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items.first
    assert_equal 5, invoice.items.count
  end

  def test_invoices_have_attached_transactions
    invoice = @i.find_by_id(20)

    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions.first
    assert_equal 3, invoice.transactions.count
  end

  def test_invoice_has_customers
    invoice = @i.find_by_id(20)

    assert_instance_of Customer, invoice.customer
    assert_equal "Sylvester", invoice.customer.first_name
  end

end
