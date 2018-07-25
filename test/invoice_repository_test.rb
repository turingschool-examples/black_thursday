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

  def test_it_finds_by_merchant_id
    assert_equal [@invoice_2], @invoice_repository.find_all_by_merchant_id(2289)
    assert_equal [], @invoice_repository.find_all_by_merchant_id(3)
  end

  def test_it_finds_by_status
    assert_equal @invoices, @invoice_repository.find_all_by_status("pending")
    assert_equal [], @invoice_repository.find_all_by_status("complete")
  end

  def test_it_creates_new_invoice
    attributes = ({:id => 2, :customer_id => 26, :merchant_id => 1355, :status => "pending", :created_at => Time.now, :updated_at => Time.now})

    assert_equal 3, @invoice_repository.all.count

    @invoice_repository.create(attributes)

    assert_equal 4, @invoice_repository.all.count
  end

  def test_invoice_can_be_updated
    original_time = @invoice_3.updated_at
    @invoice_repository.update(8, {:status => "complete", :created_at => Time.now, :updated_at => Time.now})

    assert_equal 8, @invoice_3.id
    assert_equal "complete", @invoice_3.status
    assert @invoice_3.updated_at > original_time
  end

  def test_invoice_can_be_deleted
    assert_equal 3, @invoices.count

    @invoice_repository.delete(8)

    assert_equal 2, @invoices.count
    assert_equal nil, @invoice_repository.find_by_id(8)
  end
end
