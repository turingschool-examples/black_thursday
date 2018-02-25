require './test/test_helper'
require './lib/transaction_repository'

# Tests transaction repository
class TransactionRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/transactions.csv'
    mock_invoice = mock('Invoice')
    mock_se = stub(find_transaction_invoice: mock_invoice)
    @trans_repo = TransactionRepository.new(file_name, mock_se)
  end

  def test_transaction_repository_class_exists
    assert_instance_of TransactionRepository, @trans_repo
  end

  def test_transaction_repository_adds_self_to_transaction
    assert_equal @trans_repo, @trans_repo.all.first.parent
  end

  def test_all_method
    all_transactions = @trans_repo.all
    assert_instance_of Array, all_transactions
    assert_instance_of Transaction, all_transactions.first
    assert_equal 1, all_transactions.first.id
    assert_equal 5, all_transactions.length
  end

  def test_find_by_id
    assert_nil @trans_repo.find_by_id(8)
    assert_instance_of Transaction, @trans_repo.find_by_id(2)
    assert_equal 2, @trans_repo.find_by_id(2).id
  end

  def test_find_all_by_invoice_id
    assert_empty @trans_repo.find_all_by_invoice_id(4)
    assert_instance_of Transaction, @trans_repo.find_all_by_invoice_id(46)[0]
    assert_instance_of Transaction, @trans_repo.find_all_by_invoice_id(750)[0]
    assert_equal 2, @trans_repo.find_all_by_invoice_id(46)[0].id
  end

  def test_find_all_by_credit_card_number
    card = 404_803_345_106_737_0
    expected = @trans_repo.find_all_by_credit_card_number(card)

    assert_equal [], @trans_repo.find_all_by_credit_card_number(2)
    assert_equal 2, expected.length
    assert_equal 4, expected.first.id
    assert_equal 5, expected.last.id
  end

  def test_find_all_by_result
    expected = @trans_repo.find_all_by_result('success')

    assert_empty @trans_repo.find_all_by_result('fail')
    assert_equal 5, expected.length
  end

  def test_it_asks_parent_for_invoice
    assert_instance_of Mocha::Mock, @trans_repo.invoice('invoice')
  end

  def test_inspect
    expected = '#<TransactionRepository 5 rows>'
    assert_equal expected, @trans_repo.inspect
  end
end
