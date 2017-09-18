require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class TransactionRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @repository = engine.transactions
    @transactions = engine.transaction_list
  end


  def test_it_exists
    assert_instance_of TransactionRepository, @repository
  end

  def test_it_creates_item_objects_for_each_row
    assert_instance_of Transaction, @transactions[0]
  end

  def test_all_returns_array_of_all_item_objects
    assert_equal 12, @transactions.count
  end

  def test_find_by_id_returns_nil_if_no_id_found
    assert_nil(@repository.find_by_id(000000))
  end

  def test_find_by_id_returns_item_of_matching_id
    transaction = @repository.find_by_id(531)

    assert_equal 1495, transaction.invoice_id

    transaction = @repository.find_by_id('531')

    assert_equal 1495, transaction.invoice_id
  end

  def test_find_all_by_invoice_id_returns_empty_with_no_matching_transactions
    assert_empty(@repository.find_all_by_invoice_id(0))
  end

  def test_find_all_by_invoice_id_returns_all_matching_transactions
    transactions = @repository.find_all_by_invoice_id('1495')

    assert_equal 2, transactions.count
  end


  def test_find_all_by_credit_card_number_returns_empty_with_no_matching_card
  assert_empty(@repository.find_all_by_credit_card_number(0))
  end

  def test_it_finds_all_transactions_with_matching_credit_card
    transactions = @repository.find_all_by_credit_card_number('4134214819227763')

    assert_equal 1, transactions.count
  end

  def test_it_returns_empty_array_if_no_match_by_result
    assert_empty(@repository.find_all_by_result('done'))
  end

  def test_it_finds_all_by_result
    transactions = @repository.find_all_by_result('failed')
    assert_equal 4, transactions.count
  end

end
