require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_returns_array_of_all_invoices
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_equal 1367, invoices.all.count
  end

  def test_it_can_find_by_id
    invoice = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice.find_by_id(12335311)
    assert_equal 12335311, invoice.find_by_id(12335311).id
  end
end
