require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative'../lib/sales_engine'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv"})
    @invoice_repo = InvoiceRepository.new(@se.csv_hash[:invoices])
    @invoice_repo.create_invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_all
    assert_equal 8, @invoice_repo.all.count
  end

  def test_it_can_find_by_id
    assert_equal Invoice, @invoice_repo.find_by_id(2).class
  end

  def test_it_can_find_all_by_customer_id
    assert_equal 7,  @invoice_repo.find_all_by_customer_id(1).count
  end

  def test_it_can_all_by_merchant_id
    assert_equal 2, @invoice_repo.find_all_by_merchant_id(12334269).count
  end

  def test_it_can_find_all_by_stauts
    assert_equal 3, @invoice_repo.find_all_by_status(:shipped).count
  end

  def test_it_can_create_new_id
    invoice = @invoice_repo.create_id
    assert_equal 9, invoice
  end

  def test_it_can_create_new_invoice
    attributes = {  customer_id: 11,
                  merchant_id: 1234,
                  status: 'pending',
                  created_at: '2018-12-24',
                  updated_at: '2018-12-25',
                }
    invoice = @invoice_repo.create(attributes)
    assert_equal 9, invoice.id
    assert_equal 11, invoice.customer_id
    assert_equal 1234, invoice.merchant_id
    assert_equal :pending, invoice.status
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
  end
  
  def test_it_can_update_attributes
    attributes = {status: "pending"}
    id = 2
    invoice = @invoice_repo.update(id, attributes)
    assert_instance_of Time, invoice.updated_at
    assert_equal "pending", invoice.status
    assert_equal 2, invoice.id
    assert_equal 12334269, invoice.merchant_id
  end

  def test_it_can_delete_invoice
    @invoice_repo.delete(1)
    assert_nil @invoice_repo.find_by_id(1)
  end
end
