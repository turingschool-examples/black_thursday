require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_1 = Invoice.new({:id => 6, :customer_id => 26, :merchant_id => 1355, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoice_2 = Invoice.new({:id => 7, :customer_id => 37, :merchant_id => 2289, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoice_3 = Invoice.new({:id => 8, :customer_id => 48, :merchant_id => 4934, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoices = [@invoice_1, @invoice_2, @invoice_3]
    @invoice_repository = InvoiceRepository.new(@invoices)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_finds_all_invoices
    assert_equal @invoices, @invoice_repository.all
  end

  def test_it_finds_invoice_by_id
    assert_equal @invoice_1, @invoice_repository.find_by_id(6)
    assert_equal nil, @invoice_repository.find_by_id(10)
  end

  def test_it_finds_by_customer_id
    assert_equal [@invoice_1], @invoice_repository.find_all_by_customer_id(26)
    assert_equal [], @invoice_repository.find_all_by_customer_id(10000)
  end

end
