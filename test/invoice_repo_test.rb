require "./test/test_helper"
require "./lib/invoice_repo"

class InvoiceRepoTest < Minitest::Test

  def test_it_can_retun_the_full_invoice_count
    filepath = "./data/support/invoices_support.csv"
    merch_repo = InvoiceRepo.new(filepath)
    assert_equal 201, merch_repo.all.count
  end

  def test_it_can_find_a_merchant_via_id_number
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal 4, invoice_repo.find_by_id(4).id
  end

  def test_nil_is_returned_if_id_is_invalid
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal nil, invoice_repo.find_by_id("2345642")
  end

  def test_it_can_find_all_the_customers_by_id
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal [], invoice_repo.find_all_by_customer_id("sdfsdfdtf")
    assert_equal [], invoice_repo.find_all_by_customer_id("123245")
    assert_equal [], invoice_repo.find_all_by_customer_id("~3~>fdgins")
  end

  def test_it_returns_an_empty_array_if_no_invoices_found
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal 8, invoice_repo.find_all_by_customer_id("1").count
  end

  def test_it_can_find_all_invoices_wit_a_merchant_id
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal 2, invoice_repo.find_all_by_merchant_id("12335955").count
  end

  def test_it_can_find_all_the_mercahnts_by_id
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal [], invoice_repo.find_all_by_merchant_id("sdfsdfdtf")
    assert_equal [], invoice_repo.find_all_by_merchant_id("123245")
    assert_equal [], invoice_repo.find_all_by_merchant_id("~3~>fdgins")
  end

  def test_it_can_find_all_invoices_by_status
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal 57, invoice_repo.find_all_by_status(:pending).count
  end

  def test_it_returns_an_empty_array_if_no_status_found
    filepath = "./data/support/invoices_support.csv"
    invoice_repo = InvoiceRepo.new(filepath)
    assert_equal [], invoice_repo.find_all_by_status("pend")
  end

end
