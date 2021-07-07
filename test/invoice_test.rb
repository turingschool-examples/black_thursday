require_relative 'test_helper'
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

    assert_equal 17, id
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

  def test_invoice_can_check_merchant
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
    invoices = se.invoices
    invoice = invoices.find_all_by_merchant_id(12335119)[0]
    merchant = invoice.merchant

    assert_instance_of Merchant, merchant
  end

end
