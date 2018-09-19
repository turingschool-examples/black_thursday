require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_that_it_exists
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_that_it_loads_a_repository_of_invoices
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    assert_equal 4985, invoice_repository.all.count
    assert_instance_of Invoice, invoice_repository.all[54]
  end

  def test_that_it_can_find_by_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    invoice = invoice_repository.find_by_id(345)

    invoice_id = invoice.id
    customer_id = invoice.customer_id
    merchant_id = invoice.merchant_id

    assert_equal 345, invoice_id
    assert_equal 70, customer_id
    assert_equal 12335971, merchant_id
    assert_equal :shipped, invoice.status
  end

  def test_that_it_can_find_by_merchant_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    invoice = invoice_repository.find_by_id(702)

    invoice_id = invoice.id
    customer_id = invoice.customer_id
    merchant_id = invoice.merchant_id

    assert_equal 702, invoice_id
    assert_equal 135, customer_id
    assert_equal 12336134, merchant_id
    assert_equal :shipped, invoice.status
  end

  def test_that_it_can_find_all_by_customer_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    array_of_invoices = invoice_repository.find_all_by_customer_id(300)

    assert_equal 10, array_of_invoices.count

    empty_array = invoice_repository.find_all_by_customer_id(2000)
    assert_equal [], empty_array
  end

  def test_it_can_find_all_by_status
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    shipped_array = invoice_repository.find_all_by_status(:shipped)
    pending_array = invoice_repository.find_all_by_status(:pending)
    sold_array = invoice_repository.find_all_by_status(:sold)

    assert_equal 2839, shipped_array.count
    assert_equal 1473, pending_array.count
    assert_equal [], sold_array
  end

  def test_that_create_makes_a_new_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    invoice_repository.create(attributes)
    expected = invoice_repository.find_by_id(4986)

    assert_equal 8, expected.merchant_id
  end

  def test_that_update_changes_an_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    old_update_time = invoice_repository.find_by_id(2345).updated_at
    invoice_repository.update(2345, {status: :returned})

    updated_invoice = invoice_repository.find_by_id(2345)

    assert_equal :returned, updated_invoice.status
    assert updated_invoice.updated_at > old_update_time
  end

  def test_that_delete_deletes_an_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    invoice_repository.delete(702)

    assert_nil invoice_repository.find_by_id(702)
  end
end
