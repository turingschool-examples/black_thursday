require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_returns_array_of_all_invoices
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_equal 4985, invoice.all.count
  end

  def test_it_can_find_by_id
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice.find_by_id(1)
    assert_equal 5, invoice.find_by_id(5).id
  end

  def test_it_can_find_all_by_merchant_id

    invoice = InvoiceRepository.new("./data/invoices.csv")
    instances = invoice.find_all_by_merchant_id(12336161)

    assert_equal 12336161, instances[3].merchant_id
    assert_equal 9, instances.count
  end

  def test_it_can_find_all_by_customer_id
    invoice = InvoiceRepository.new("./data/invoices.csv")
    instances = invoice.find_all_by_customer_id(7)


    assert_equal 7, instances[0].customer_id
    assert_equal 4, instances.count
  end

  def test_it_can_find_by_status
    invoice = InvoiceRepository.new("./data/invoices.csv")

    instances =invoice.find_all_by_status("pending")
    assert_equal "pending", instances[5].status

    instances = invoice.find_all_by_status("shipped")
    assert_equal "shipped", instances[4].status
  end
end
