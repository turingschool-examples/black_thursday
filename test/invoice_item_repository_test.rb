require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :parent, :repo

  def setup
    @parent = Minitest::Mock.new 
    @repo   = InvoiceItemRepository.new('./test/assets/test_invoice_items.csv', parent)
  end

  def test_repo_all_holds_array_of_all_invoice_items
    assert_equal 99, repo.all.count
  end

  def test_repo_can_find_by_invoice_item_id
    assert_equal 9, repo.find_by_id(6).item_id
  end

  def test_repo_returns_nil_when_id_not_found
    assert_equal nil, repo.find_by_id(405983495349534958)
  end

  def test_repo_can_return_array_of_all_invoice_items_with_item_id
    assert_equal 3, repo.find_all_by_item_id(55).count
  end

  def test_repo_returns_empty_array_when_item_id_not_found
    assert_equal [], repo.find_all_by_item_id(700)
  end

  def test_repo_returns_array_of_all_invoice_items_with_invoice_id
    assert_equal 3, repo.find_all_by_invoice_id(1).count
  end

  def test_repo_returns_empty_array_when_invoice_id_not_found
    assert_equal [], repo.find_all_by_invoice_id(0)
  end

end

