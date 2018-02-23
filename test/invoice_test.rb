require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# test for invoice class
class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({ id: 6,
                       customer_id: 7,
                       merchant_id: 8,
                       status: 'pending',
                       created_at: '2009-02-07',
                       updated_at: '2014-03-15' },
                     'parent')
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_it_has_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal :pending, @i.status
  end

  def test_it_has_more_attributes
    assert_equal Time.parse('2009-02-07'), @i.created_at
    assert_equal Time.parse('2014-03-15'), @i.updated_at
    assert_equal 'parent', @i.parent
  end

  def test_it_can_return_merchant_class
    skip
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv',
                              invoices: './test/fixtures/invoices.csv')
    parent = InvoiceRepository.new('./test/fixtures/invoices.csv', se)
    data = { id: 6,
             customer_id: 7,
             merchant_id: 2,
             status: :pending,
             created_at: '2009-02-07',
             updated_at: '2014-03-15' }
    invoice = Invoice.new(data, parent)

    assert_instance_of Merchant, invoice.merchant
    assert_equal invoice.merchant.id, invoice.merchant_id
  end

  def test_it_can_get_invoice_items
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    parent = InvoiceRepository.new('./test/fixtures/invoices.csv', se)
    invoice = se.invoices.find_by_id(1)

    assert_instance_of InvoiceItem, invoice.items.first
    assert_equal 1, invoice.items.first.id
  end
end
