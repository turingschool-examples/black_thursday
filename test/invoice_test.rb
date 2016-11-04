require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
#require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
    attr_reader   :invoice,
                  :invoice_2

  def setup
    #@repository = InvoiceRepository.new('./fixture/invoices.csv')
    
    @invoice = Invoice.new({
      :id => "1",
      :customer_id => "1",
      :merchant_id => "101",
      :status => "pending",
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC",
    })

    @invoice_2 = Invoice.new({
      :id => "2",
      :customer_id => "2",
      :merchant_id => "102",
      :status => "pending",
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC",
    })
  end

  def test_it_can_create_an_invoice
    assert invoice
    assert invoice_2
  end

  def test_it_can_return_invoice_id
    assert_equal 1, invoice.id
    assert_equal 2, invoice_2.id
  end

  def test_it_can_return_customer_id
    assert_equal 1, invoice.customer_id
    assert_equal 2, invoice_2.customer_id
  end

  def test_it_can_return_merchant_id
    assert_equal 101, invoice.merchant_id
    assert_equal 102, invoice_2.merchant_id
  end

  def test_it_can_return_status
    assert_equal "pending", invoice.status
    assert_equal "pending", invoice_2.status
  end

  def test_it_can_return_created_at_as_time
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice_2.created_at
  end

  def test_it_can_return_updated_at_as_time
    assert_instance_of Time, invoice.updated_at
    assert_instance_of Time, invoice_2.updated_at
  end

  def test_that_an_invoice_knows_who_its_parent_is
    skip
    assert_equal repository, invoice.parent
    assert_instance_of InvoiceRepository, invoice_2.parent
  end

  def test_an_invoice_can_point_to_its_merchant
    skip
    sales_engine = SalesEngine.from_csv({ 
      :invoices => "./fixture/invoices.csv" 
    })

  end
end