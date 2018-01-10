require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
  end


  def test_it_exists
    invoice = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_returns_all_invoices
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")

    assert_equal 19, invoices.all.count
    refute_equal "19", invoices.all.count
  end

  def test_it_finds_by_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket1 = invoices.find_by_id(641)
    invoice_ticket2 = invoices.find_by_id(819)
    invoice_ticket3 = invoices.find_by_id(4800)

    assert_equal 12334141, invoice_ticket1.merchant_id
    refute_equal "12334141", invoice_ticket1.merchant_id
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

  def test_it_finds_all_invoice_id
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_invoice_id(1053)

    assert_equal 4, invoice_ticket.count
  end

  def test_it_finds_all_by_status
    invoices = InvoiceRepository.new("./test/fixtures/invoices_sample.csv", "se")
    invoice_ticket = invoices.find_all_by_status(:shipped)

    assert_equal 12, invoice_ticket.count
  end

  def test_it_finds_merchant_by_invoice
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      merchants: "./test/fixtures/merchants_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    merchant = se.invoices.find_merchant_by_merchant_id(12334141)

    assert_equal "jejum", merchant.name
    refute_equal "jjum", merchant.name
  end

  def test_it_grabs_array_of_invoices
    se = SalesEngine.from_csv({
      :merchants => "./test/fixtures/merchants_sample.csv",
      :invoices => "./test/fixtures/invoices_sample.csv"
    })
    found_merchants = se.merchants.grab_array_of_invoices

    assert_equal [8, 2, 1, 1, 1, 1, 1], found_merchants
    assert_equal 7, found_merchants.count
  end

  def test_it_grabs_all_items
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      merchants: "./test/fixtures/merchants_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    result = se.invoices.grab_all_items

    assert_equal 25, result.count
  end

end
