require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :repo

  def setup
    @repo = InvoiceRepository.new('./test/assets/small_invoice.csv')
  end

  def test_that_invoice_repository_is_array_of_invoices
    assert_equal 14, repo.all.count
  end

  def test_find_by_id_returns_instance_of_invoice_with_id
    assert_equal 2, repo.find_by_id(9).customer_id
  end

  def test_find_by_id_returns_nil_if_no_matching_invoice_id
    refute repo.find_by_id(1000)
  end

  def test_find_all_by_merchant_id_returns_array_of_a_merchants_invoices
    assert_equal 2, repo.find_all_by_merchant_id(12335955).count
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_id_not_found
    assert_equal [], repo.find_all_by_merchant_id(20)
  end

  def test_find_all_by_customer_id_returns_array_of_invoices_with_matching_customer_id
    assert_equal 4, repo.find_all_by_customer_id(2).count
  end

  def test_find_all_by_customer_id_returns_empty_array_if_id_not_found
    assert_equal [], repo.find_all_by_customer_id(20)
  end

  def test_find_all_invoices_that_have_a_certain_status
    assert_equal 6, repo.find_all_by_status(:shipped).count
  end

  def test_find_all_invoices_returns_empty_array_if_no_matching_status
    assert_equal [], repo.find_all_by_status(:turd)
  end
end