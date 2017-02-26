require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  attr_reader :file_hash, :path, :se, :repo, :invoice

  def setup
    @file_hash = { customers: './data/customers.csv',
                  transactions: './data/transactions.csv',
                  invoices: './data/invoices.csv',
                  items: './data/items.csv',
                  merchants: './data/merchants.csv',
                  invoice_items: './data/invoice_items.csv'
                  }
    @path = 'test/fixtures/invoice_sample.csv'
    @se = SalesEngine.from_csv(file_hash)
    @repo = Repository.new(se, path, Invoice)
    @invoice = Invoice.new( {:id => 1,
                      :customer_id => 1,
                      :merchant_id => 12335938,
                      :status => "pending",
                      :created_at => "2014-03-15",
                      :updated_at=> "2014-03-15"
                      }, repo)
  end

  def test_it_creates_an_instance_of_invoice
    assert invoice
  end

  def test_id
    assert_equal 1, invoice.id
  end


  def test_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_merchant_id
    assert_equal 12335938, invoice.merchant_id
  end


  def test_status
    assert_equal :pending, invoice.status
  end


  def test_created_at
    assert_equal Time, invoice.created_at.class
  end


  def test_updated_at
    assert_equal Time, invoice.updated_at.class
  end

  def test_if_finds_the_day_of_the_week_of_an_invoice
    assert_equal "Saturday", invoice.day_of_the_week_on_which_an_invoice_is_created

  end

end
