require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
  end

  def test_it_returns_all_invoices
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.all

    assert_equal 18, invoice_ticket.count
  end

  def test_it_exists
    invoice = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_finds_by_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket1 = invoices.find_by_id(641)
    invoice_ticket2 = invoices.find_by_id(819)
    invoice_ticket3 = invoices.find_by_id(4800)

    assert_equal 12334141, invoice_ticket1.merchant_id
    assert_equal 12334141, invoice_ticket2.merchant_id
    assert_equal 12334183, invoice_ticket3.merchant_id
  end

  def test_it_finds_all_customers_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_customer_id(528)

    assert_equal 1, invoice_ticket.count
  end

  def test_it_finds_all_merchant_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_merchant_id(12334141)

    assert_equal 8, invoice_ticket.count
  end

  def test_it_finds_all_by_status
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_status(:shipped)

    assert_equal 11, invoice_ticket.count
  end

  def test_it_returns_all_invoices
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.all

    assert_equal 18, invoice_ticket.count
  end

end
