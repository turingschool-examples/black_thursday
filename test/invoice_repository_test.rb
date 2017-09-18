require './test/test_helper'

require './lib/invoice_repository'
require './lib/invoice'


class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repo
  def setup
    @invoice_repo = Fixture.repo(:invoices)
  end

  def test_initialize_takes_a_sales_engine_and_an_array_of_record_data
    args = [Fixture.sales_engine, Fixture.data[:invoices]]
    assert_instance_of InvoiceRepository, InvoiceRepository.new(*args)
  end

  def test_all_returns_an_array_of_all_invoices
    assert_instance_of Array, invoice_repo.all
    assert invoice_repo.all.all?{ |invoice| invoice.is_a? Invoice }
  end

  def test_find_by_id_returns_invoice_with_that_id_if_contained
    invoice = invoice_repo.find_by_id(74)
    assert_instance_of Invoice, invoice
    assert_equal 74, invoice.id
  end

  def test_find_by_id_returns_nil_if_not_contained
    assert_nil invoice_repo.find_by_id(-1)
  end

  def test_find_all_by_merchant_id_returns_array_of_matching_invoices
    invoices = invoice_repo.find_all_by_merchant_id(12334105)
    assert_instance_of Array, invoices
    refute_empty invoices
    assert invoices.all? do |invoice|
      invoice.is_a? Invoice && invoice.merchant_id == 12334105
    end
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_no_matches
    assert_equal [], invoice_repo.find_all_by_merchant_id(-1)
  end

  def test_find_all_by_customer_id_returns_array_of_matching_invoices
    invoices = invoice_repo.find_all_by_customer_id(14)
    assert_instance_of Array, invoices
    refute_empty invoices
    assert invoices.all? do |invoice|
      invoice.is_a? Invoice && invoice.customer_id == 14
    end
  end

  def test_find_all_by_customer_id_returns_empty_array_if_no_matches
    assert_equal [], invoice_repo.find_all_by_customer_id(-1)
  end

  def test_find_all_by_status_returns_array_of_matching_invoices
    invoices = invoice_repo.find_all_by_status(:pending)
    assert_instance_of Array, invoices
    refute_empty invoices
    assert invoices.all? do |invoice|
      invoice.is_a? Invoice && invoice.status == :pending
    end
  end

  def test_find_all_by_status_returns_empty_array_if_no_matches
    assert_equal [], invoice_repo.find_all_by_status(:totally_fake)
  end

end
