require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    @data = {
      id: 1,
      customer_id: 1,
      merchant_id: 123_359_38,
      status: 'pending',
      created_at: '2009-02-07',
      updated_at: '2014-03-15'
    }
    @invoice = Invoice.new(@data, 'ItemRepository pointer')
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_attributes_set_correctly
    assert_equal 'ItemRepository pointer', @invoice.parent
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 123_359_38, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal Time.new(2009, 02, 07), @invoice.created_at
    assert_equal Time.new(2014, 03, 15), @invoice.updated_at
  end

  def test_finding_merchant_associated_with_invoice
    information = { items: './test/fixtures/items_list_truncated.csv',
                    merchants: './test/fixtures/merchants_list_truncated.csv',
                    invoices: './test/fixtures/invoices_list_truncated.csv' }
    sales_engine = SalesEngine.from_csv(information)
    invoice = sales_engine.invoices.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 123_361_63, invoice.merchant.id
  end
end
