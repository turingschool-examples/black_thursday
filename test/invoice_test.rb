gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def test_invoice_exists
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)

    assert_instance_of Invoice, invoice
  end

  def test_invoice_has_id
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    id = invoice.id

    assert_equal 17, invoice.id
  end

  def test_invoice_has_customer_id
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    customer_id = invoice.customer_id

    assert_equal 5, customer_id
  end

  def test_invoice_has_merchant_id
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    merchant_id = invoice.merchant_id

    assert_equal 12334912, merchant_id
  end

  def test_invoice_has_status
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    status = invoice.status

    assert_equal "pending", status
  end

  def test_invoice_has_created_at
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    created_at = invoice.created_at

    assert_instance_of Time, created_at
  end

  def test_invoice_has_updated_at
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)
    updated_at = invoice.updated_at

    assert_instance_of Time, updated_at
  end

  def test_invoice_can_check_for_merchants
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
    binding.pry
    invoice = se.invoices.find_by_id(71)
    merchant = se.merchants.find_by_id(12336292)

    assert_equal invoice.merchant_id, merchant.id
  end

end
