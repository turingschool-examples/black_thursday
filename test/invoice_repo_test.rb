require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exist
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")

    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_can_find_by_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")
    id = 1

    assert_instance_of Invoice, invoice_repo.find_by_id(id)
  end

  def test_it_can_find_all_by_customer_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")
    customer_id = 1

    assert_instance_of Array, invoice_repo.find_all_by_customer_id(customer_id)
  end

  def test_invoices_are_placed_in_array
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")
    customer_id = 1

    assert_instance_of Invoice, invoice_repo.find_all_by_customer_id(customer_id)[0]
  end

  def test_can_find_all_by_merchant_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")
    merchant_id = 12335938

    assert_instance_of Array, invoice_repo.find_all_by_merchant_id(merchant_id)
  end

  def test_invoices_are_placed_in_array
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")
    merchant_id = 12335938

    assert_instance_of Invoice, invoice_repo.find_all_by_merchant_id(merchant_id)[0]

  end

end
