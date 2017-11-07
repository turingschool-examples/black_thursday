require_relative 'test_helper'
require_relative "../lib/invoice_repo"

class InvoiceRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of InvoiceRepository, InvoiceRepository.new(self, "./data/invoices.csv")
  end

  def test_it_can_create_invoice_instances
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.invoices.first
  end

  def test_it_can_reach_the_invoice_instances_through_all
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.all.first
  end

  def test_it_can_find_invoices_by_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_by_id(3311)

    assert_equal 12335660, results.merchant_id
  end

  def test_it_can_find_invoices_by_customer_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_customer_id(300)

    assert_equal 10, results.length
  end

  def test_find_by_customer_id_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_customer_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_merchant_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_merchant_id(12334185)

    assert_equal 10, results.count
    assert_equal 1495, results.first.id
  end

  def test_find_by_merchant_id_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_merchant_id(000000)

    assert_equal [], results
  end

  def test_find_by_invoices_by_status
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_status(:pending)

    assert_equal 1473, results.length
  end

  def test_find_by_status_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_status(:received)

    assert_equal [], results
  end

end
