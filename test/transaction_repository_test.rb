require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    transaction_csv = './test/fixtures/transactions_list_truncated.csv'
    parent = 'parent'
    @tr = TransactionRepository.new(transaction_csv, parent)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
    assert_equal 'parent', @tr.parent
  end

  def test_transactions_csv_parsed
    assert_equal 22, @tr.transactions.length
    assert_equal 1, @tr.transactions.first.id
  end

  def test_all_transactions
    assert_equal 22, @tr.all.length
    assert @tr.all[3].is_a?(Transaction)
    assert_equal 4048033451067370, @tr.all[3].credit_card_number
  end

  def test_find_by_id
    assert_nil @tr.find_by_id(35)
    assert_equal 547, @tr.find_by_id(16).invoice_id
  end

  def test_find_all_by_invoice_id
    actual = @tr.find_all_by_invoice_id(2668).first.credit_card_number

    assert_equal [], @tr.find_all_by_invoice_id(5)
    assert_equal 4890371279632775, actual
  end

  def test_find_all_by_credit_card_number
    actual = @tr.find_all_by_credit_card_number(4055813232766404).first.id

    assert_equal [], @tr.find_all_by_credit_card_number(2345)
    assert_equal 18, actual
  end

  def test_find_all_by_result
    assert_equal [], @tr.find_all_by_result('pending')
    assert_equal 3, @tr.find_all_by_result('failed').length
    assert_instance_of Transaction, @tr.find_all_by_result('failed').first
    assert_equal 9, @tr.find_all_by_result('failed').first.id
  end

  def test_inspect
    assert_equal '#<TransactionRepository 22 rows>', @tr.inspect
  end
end
