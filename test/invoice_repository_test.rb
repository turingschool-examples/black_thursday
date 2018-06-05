require_relative 'test_helper'
require './lib/invoice_repository'

class TestInvoiceRepository < Minitest::Test
  def setup
    @loaded_file = [{id: 1, customer_id: 1, merchant_id: 1, status: 'pending', created_at: '2009-02-07', updated_at: '2010-03-15'},
                    {id: 2, customer_id: 1, merchant_id: 1, status: 'shipped', created_at: '2005-03-07', updated_at: '2011-03-15'},
                    {id: 3, customer_id: 2, merchant_id: 1, status: 'pending', created_at: '2009-06-07', updated_at: '2010-03-15'},
                    {id: 4, customer_id: 2, merchant_id: 3, status: 'shipped', created_at: '2001-01-07', updated_at: '2006-03-15'},
                    {id: 5, customer_id: 3, merchant_id: 1, status: 'pending', created_at: '2009-02-07', updated_at: '2014-03-15'},
                    {id: 6, customer_id: 3, merchant_id: 2, status: 'shipped', created_at: '2010-03-07', updated_at: '2014-06-15'},
                    {id: 7, customer_id: 4, merchant_id: 2, status: 'pending', created_at: '2009-02-07', updated_at: '2014-01-15'},
                    {id: 8, customer_id: 4, merchant_id: 3, status: 'shipped', created_at: '2011-04-11', updated_at: '2014-02-15'},
                    {id: 9, customer_id: 5, merchant_id: 4, status: 'pending', created_at: '2011-05-10', updated_at: '2014-05-15'},
                    {id: 10, customer_id: 5, merchant_id: 6, status: 'shipped', created_at: '2009-02-08', updated_at: '2014-03-15'},
                    {id: 11, customer_id: 6, merchant_id: 5, status: 'pending', created_at: '2010-02-08', updated_at: '2012-03-15'},
                    {id: 12, customer_id: 6, merchant_id: 5, status: 'shipped', created_at: '2012-01-07', updated_at: '2013-03-15'},
                    {id: 13, customer_id: 7, merchant_id: 6, status: 'pending', created_at: '2009-02-07', updated_at: '2012-03-15'},
                    {id: 14, customer_id: 7, merchant_id: 7, status: 'shipped', created_at: '2009-02-07', updated_at: '2013-03-15'},
                    {id: 15, customer_id: 8, merchant_id: 8, status: 'pending', created_at: '2001-02-07', updated_at: '2015-03-15'},
                    {id: 16, customer_id: 8, merchant_id: 9, status: 'shipped', created_at: '2002-02-07', updated_at: '2015-03-15'},
                    {id: 17, customer_id: 9, merchant_id: 10, status: 'pending', created_at: '2003-02-07', updated_at: '2016-03-15'},
                    {id: 18, customer_id: 9, merchant_id: 11, status: 'shipped', created_at: '2004-02-07', updated_at: '2017-03-15'},
                    {id: 19, customer_id: 10, merchant_id: 12, status: 'shipped', created_at: '2005-02-07', updated_at: '2018-03-15'},
                    {id: 20, customer_id: 10, merchant_id: 12, status: 'pending', created_at: '2001-02-07', updated_at: '2017-03-15'}]
    @ir = InvoiceRepository.new(@loaded_file)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_returns_all_invoices
    assert_equal 20, @ir.all.count
  end

  def test_it_finds_invoice_by_id
    invoice = @ir.find_by_id(10)

    assert_equal 10, invoice.id
    assert_equal 5, invoice.customer_id
    assert_equal 6, invoice.merchant_id
    assert_equal :shipped, invoice.status
  end

  def test_it_returns_all_invoices_associated_with_given_customer
    invoices = @ir.find_all_by_customer_id(2)

    assert_equal 2, invoices.length
    assert_equal [], @ir.find_all_by_customer_id(100)
  end

  def test_it_finds_all_invoices_for_a_given_merchant_id
    invoices = @ir.find_all_by_merchant_id(5)

    assert_equal 2, invoices.length
    assert_equal [], @ir.find_all_by_merchant_id(100)
  end

  def test_it_finds_all_invoices_of_a_given_status
    invoices = @ir.find_all_by_status(:pending)

    assert_equal 10, invoices.length
    assert_equal [], @ir.find_all_by_status(:sold)
  end

  def test_it_creates_new_instance_of_invoice
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }

    @ir.create(attributes)
    invoice = @ir.find_by_id(21)
    assert_equal 8, invoice.merchant_id
  end

  def test_it_updates_an_invoice
    original_time = @ir.find_by_id(20).updated_at
    attributes = { :status => :success }

    @ir.update(20, attributes)
    invoice = @ir.find_by_id(20)
    assert_equal :success, invoice.status
    assert_equal 10, invoice.customer_id
    assert invoice.updated_at > original_time
  end

  def test_it_deletes_invoice_by_id
    @ir.delete(1)
    invoice = @ir.find_by_id(1)
    assert_nil invoice

    assert_nil @ir.delete(5000)
  end
end
