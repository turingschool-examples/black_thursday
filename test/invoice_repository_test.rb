require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :repo, :parent

  def setup
    @parent = Minitest::Mock.new
    @repo = InvoiceRepository.new('./test/assets/small_invoice.csv', parent)
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

  def test_it_calls_parent_when_looking_for_merchant
    parent.expect(:find_merchant_by_merchant_id, nil, [2])
    repo.find_merchant_by_id(2)
    parent.verify
  end

  def test_it_calls_parent_when_looking_for_transactions
    parent.expect(:find_transactions_by_invoice_id, nil, [2])
    repo.find_transactions_by_invoice_id(2)
    parent.verify
  end

  def test_it_calls_parent_when_looking_for_invoice_items
    parent.expect(:find_invoice_items_by_invoice_id, nil, [2])
    repo.find_invoice_items_by_invoice_id(2)
    parent.verify
  end

  def test_it_calls_parent_when_looking_for_items
    parent.expect(:find_item_by_item_id, nil, [2])
    repo.find_item_by_item_id(2)
    parent.verify
  end

end