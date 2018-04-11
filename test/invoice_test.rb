require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

# Test Invoice class
class InvoiceTest < Minitest::Test

  def setup
    @time = Time.now
    @inv = Invoice.new(
                      id:          3,
                      customer_id: 7,
                      merchant_id: 8,
                      status:      'pending',
                      created_at:  @time,
                      updated_at:  @time
                      )
  end

  def test_it_exists
    assert_instance_of Invoice, @inv
  end

  def test_it_has_attributes
    assert_equal 3, @inv.id
    assert_equal 7, @inv.customer_id
    assert_equal 8, @inv.merchant_id
    assert_equal :pending, @inv.status
    assert_equal @time, @inv.created_at
    assert_equal @time, @inv.updated_at
  end

  def test_it_returns_merchant
    se = SalesEngine.from_csv(
                              items:      './data/items.csv',
                              merchants:  './data/merchants.csv',
                              invoices:   './data/invoices.csv'
                              )
    invoice = se.invoices.find_by_id(68)
    assert_instance_of Merchant, invoice.merchant
    assert_equal 12335598, invoice.merchant.id
  end
end
