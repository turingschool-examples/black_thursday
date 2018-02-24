require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'


class InvoiceTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
      @invoice = Invoice.new({
        id:          6,
        customer_id: 7,
        merchant_id: 8,
        status:      'pending',
        created_at:  '2011-08-29 19:23:23 UTC',
        updated_at:  '2006-12-25 19:23:23 UTC'
        }, @sales_engine.invoices)
  end

  def test_it_exists
    invoice = @invoice

    assert_instance_of Invoice, invoice
  end

  def test_invoice_attributes_accessible
    invoice = @invoice

    assert_equal 6, invoice.id
    assert_equal 7, invoice.customer_id
    assert_equal 8, invoice.merchant_id
    assert_equal :pending, invoice.status
    assert_instance_of Time, invoice.created_at
  end

  def test_invoice_can_have_different_attributes
    invoice = Invoice.new({
      id:          66,
      customer_id: 77,
      merchant_id: 88,
      status:      'ready',
      created_at:  '2341-08-20 19:23:23 UTC',
      updated_at:  '1981-05-09 19:23:23 UTC'
      }, @sales_engine.invoices)


    assert_equal 66, invoice.id
    assert_equal 77, invoice.customer_id
    assert_equal 88, invoice.merchant_id
    assert_equal :ready, invoice.status
    assert_instance_of Time, invoice.created_at
  end

  def test_invoice_merchant_returns_merchant
    invoice = @sales_engine.invoices.find_by_id(12)
    invoice.merchant

    assert_nil invoice.merchant
  end

  def test_invoice_items_returns_items_array
    invoice = @sales_engine.invoices.find_by_id(2)
    invoice.items

    assert_equal 4, invoice.items.length

    invoice_bad = @sales_engine.invoices.find_by_id(64)

    assert_equal 4, invoice.items.length
    assert_nil invoice_bad
  end

  def test_invoice_customer_returns_customer
    invoice = @sales_engine.invoices.find_by_id(9)
    invoice.customer

    assert_instance_of Customer, invoice.customer
  end

  def test_invoice_paid_in_full_returns_boolean
    invoice = @sales_engine.invoices.find_by_id(46)
    result = invoice.is_paid_in_full?

    assert result
  end

  def test_invoice_total_returns
    invoice = @sales_engine.invoices.find_by_id(46)
    result = invoice.is_paid_in_full?
    result.total

    assert 986.68, result.total
  end
end
