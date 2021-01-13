require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require 'time'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = "./data/customers.csv"
    transactions_path = "./data/transactions.csv"
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path}
    @engine = SalesEngine.new(locations)
    @ir = InvoiceRepository.new('./data/invoices.csv', @engine)
  end

  def test_it_has_attributes
    invoice = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now.to_s,
  :updated_at  => Time.now.to_s,
  }, @ir)

  assert_instance_of Invoice, invoice
  assert_equal 6, invoice.id
  assert_instance_of Time, invoice.created_at
  assert_instance_of Time, invoice.updated_at
  assert_equal 8, invoice.merchant_id
  assert_equal 7, invoice.customer_id
  assert_equal :pending, invoice.status
  assert_equal "Tuesday", invoice.day_of_week
  end
end
