require './test/test_helper'
require './lib/transaction_repository'

# Tests transaction repository
class TransactionRepositoryTest < Minitest::Test
  # def setup
  #   file_name = './data/sample_data/transactions.csv'
  #   mock_invoice = mock('Invoice')
  #   mock_se = stub(invoice: mock_invoice)
  #   @trans_repo = TransactionRepository.new(file_name, mock_se)
  # end

  def test_transaction_repository_class_exists
    skip
    assert_instance_of TransactionRepository, @trans_repo
  end

  def test_transaction_repository_adds_self_to_transaction
    skip
    assert_equal @trans_repo, @trans_repo.all.first.parent
  end

  def test_all_method
    skip
    all_transactions = @trans_repo.all
    assert_instance_of Array, all_transactions
    assert_instance_of Transaction, all_transactions.first
    assert_equal 1, all_transactions.first.id
    assert_equal 4, all_transactions.length
  end

  def test_find_by_id
    skip
    assert_nil @trans_repo.find_by_id(8)
    assert_instance_of Transaction, @trans_repo.find_by_id(2)
    assert_equal 2, @trans_repo.find_by_id(2).id
  end

  def test_find_all_by_invoice_id
    skip
    assert_empty @trans_repo.find_all_by_invoice_id(4)
    assert_instance_of Transaction, @trans_repo.find_all_by_invoice_id(46)
    assert_instance_of Transaction, @trans_repo.find_all_by_invoice_id(750)
    assert_equal 2, @trans_repo.find_all_by_invoice_id(46).id
  end

  def test_find_all_by_credit_card_number
    skip
    card = 404_803_345_106_737_0
    expected = @trans_repo.find_all_by_credit_card_number(card)

    assert_equal [], @trans_repo.find_all_by_name(2)
    assert_equal 2, expected.length
    assert_equal 4, expected.first.id
    assert_equal 5, expected.last.id
  end

  def test_find_all_by_result
    skip
    expected = @trans_repo.find_all_by_result(:success)

    assert_empty @trans_repo.find_all_by_result(:fail)
    assert_equal 2, expected.length
  end

  def test_it_asks_parent_for_items
    skip
    assert_equal 2, @trans_repo.items('id').length
    @trans_repo.items('id').each do |item|
      assert_instance_of Mocha::Mock, item
    end
  end

  def test_inspect
    skip
    expected = '#<transactionRepository 4 rows>'
    assert_equal expected, @trans_repo.inspect
  end
end
