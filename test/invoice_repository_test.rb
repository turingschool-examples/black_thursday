require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    invoice = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_finds_by_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket1 = invoices.find_by_id(1)
    invoice_ticket2 = invoices.find_by_id(2)
    invoice_ticket3 = invoices.find_by_id(3)

    assert_equal 12335938, invoice_ticket1.merchant_id
    assert_equal 12334753, invoice_ticket2.merchant_id
    assert_equal 12335955, invoice_ticket3.merchant_id
  end

  def test_it_finds_all_customers_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_customer_id(1)

    assert_equal 8, invoice_ticket.count
  end

  def test_it_finds_all_merchant_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_merchant_id(12335938)

    assert_equal 1, invoice_ticket.count
  end

  def test_it_returns_all_invoices
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.all

    assert_equal 8, invoice_ticket.count
  end

end
