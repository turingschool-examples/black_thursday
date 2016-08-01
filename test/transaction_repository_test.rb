require './test/test_helper'
require './lib/transaction_repository'
require 'csv'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :tr

  def setup
    fixture = CSV.open('./test/fixtures/transactions_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @tr = TransactionRepository.new(csv_rows)
  end

  def test_method_transactions_returns_array_of_transactions
    assert_instance_of Array, tr.transactions
    assert_equal true, tr.transactions.all? { |thing| thing.class == Transaction }
  end

  def test_method_all_returns_array_of_transactions
    assert_equal tr.transactions, tr.all
  end

  def test_method_find_by_id_returns_nil_or_transaction
    transaction =     tr.find_by_id(1)
    transaction_nil = tr.find_by_id(9001)
    assert_instance_of Transaction, transaction
    assert_equal 1,          transaction.id
    assert_equal nil,        transaction_nil
  end

  def test_method_find_all_by_invoice_id_returns_array_of_transactions
    transactions = tr.find_all_by_invoice_id(46)
    transactions_multiple = tr.find_all_by_invoice_id(2179)
    transactions_empty = tr.find_all_by_invoice_id(9001)
    assert_equal 46, transactions[0].invoice_id
    assert_equal true, transactions_multiple.length > 1
    assert_equal [], transactions_empty
  end

  def test_method_find_all_by_result_returns_array_of_transactions
    transactions = tr.find_all_by_result('failed')
    transactions_multiple = tr.find_all_by_result('success')
    transactions_empty = tr.find_all_by_result('terminated')
    assert_equal 'failed', transactions[0].result
    assert_equal true, transactions_multiple.length > 1
    assert_equal [], transactions_empty
  end

  def test_method_find_invoice_by_id_returns_invoice
    mock_se = Minitest::Mock.new
    tr = TransactionRepository.new([], mock_se)
    mock_se.expect(:find_invoice_by_id, nil, [2179])
    tr.find_invoice_by_id(2179)
    assert mock_se.verify
  end
end
