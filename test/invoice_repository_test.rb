require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @ivr = @se.invoices
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @ivr.csv
  end

  def test_it_can_create_instance_of_invoice
    assert_instance_of Invoice, @ivr.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @ivr.all
  end

  def test_it_can_find_an_invoice_by_id
    invoice = @ivr.find_by_id(2502)
    assert_instance_of Invoice, invoice
  end

  def test_it_returns_nil_if_the_invoice_does_not_exist
    invoice = @ivr.find_by_id(6152)
    assert_nil invoice, 'non-existent invoice was supposed to return nil!'
  end

  def test_it_can_find_all_items_matching_customer_id_in_invoices
    invoice = @ivr.find_all_by_customer_id(811)
    assert_instance_of Invoice, invoice.first
    assert_instance_of Array, @ivr.find_all_by_customer_id(811)
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    invoice = @ivr.find_all_by_customer_id(286)
    assert_equal [], invoice
  end

  def test_it_can_find_all_items_matching_merchant_id_in_invoices
    invoice = @ivr.find_all_by_merchant_id(12334105)
    assert_instance_of Invoice, invoice.first
    assert_instance_of Array, @ivr.find_all_by_merchant_id(12334105)
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    invoice = @ivr.find_all_by_merchant_id(90907653)
    assert_equal [], invoice
  end

  def test_it_can_find_all_invoices_matching_status
    invoice = @ivr.find_all_by_status(:shipped)
    assert_equal 69, invoice.count
    assert_instance_of Array, @ivr.find_all_by_status(:shipped)
  end

  def test_it_can_return_an_empty_array_if_no_matches_are_found
    invoice = @ivr.find_all_by_status("canceled")
    assert_equal [], invoice
  end
end
