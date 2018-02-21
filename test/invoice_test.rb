require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine.rb'

class InvoiceTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.new({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv',
      invoices: './test/fixtures/invoices.csv'
      })
      @invoice = Invoice.new({
        id:          6,
        customer_id: 7,
        merchant_id: 8,
        status:      'pending',
        created_at:  Time.now,
        updated_at:  Time.now
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
    assert_equal 'pending', invoice.status
    assert_instance_of Time, invoice.created_at
  end

  def test_invoice_can_have_different_attributes
    invoice = Invoice.new({
      id:          66,
      customer_id: 77,
      merchant_id: 88,
      status:      'ready',
      created_at:  Time.at(1_498_280_000),
      updated_at:  Time.at(1_498_280_000)
      }, @sales_engine.invoices)
    created_time = Time.at(1_498_280_000)

    assert_equal 66, invoice.id
    assert_equal 77, invoice.customer_id
    assert_equal 88, invoice.merchant_id
    assert_equal 'ready', invoice.status
    assert_equal created_time, invoice.created_at
  end
end
