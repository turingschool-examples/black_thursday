require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_it_exists
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    assert_instance_of TransactionRepository, transaction_repository
  end

  def test_transaction_repository_has_transactions
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    assert_equal 4985, transaction_repository.all.count

    assert_instance_of Array, transaction_repository.all

    assert transaction_repository.all.all? { |transaction|
    transaction.is_a?(Transaction)}
    assert_equal 1, transaction_repository.all.first.id
  end

  def test_it_can_find_transaction_by_id
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    actual = transaction_repository.find_by_id(1)

    assert_instance_of Transaction, actual
    assert_equal '4068631943231473', actual.credit_card_number
    assert_equal 1, actual.id
  end

  def test_returns_nil_when_no_match_is_found
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    actual = transaction_repository.find_by_id(999999)

    assert_nil actual
  end

  def test_it_can_find_all_by_invoice_id
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    assert_equal [], transaction_repository.find_all_by_invoice_id(9191919191919)

    assert_equal [transaction_repository.all[0], transaction_repository.all[766]], transaction_repository.find_all_by_invoice_id(2179)
  end

  def test_can_find_all_by_credit_card_number
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    assert_equal [], transaction_repository.find_all_by_credit_card_number('0')

    assert_equal [transaction_repository.all[0]], transaction_repository.find_all_by_credit_card_number('4068631943231473')
  end

  def test_can_find_all_by_result
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    assert_equal [], transaction_repository.find_all_by_result('ha')

    assert_equal 4158, transaction_repository.find_all_by_result(:success).count

    assert_equal 827, transaction_repository.find_all_by_result(:failed).count
  end

  def test_can_create_a_transaction
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    new_transaction = transaction_repository.create(invoice_id: 12, credit_card_number: '123456789101112131', credit_card_expiration_date: '0920', result: 'success', created_at: Time.now, updated_at: Time.now)

    assert_instance_of Transaction, new_transaction

    actual = transaction_repository.all.last

    assert_equal transaction_repository.find_by_id(4986), actual

    assert_equal transaction_repository.find_all_by_credit_card_number('123456789101112131'), [actual]
  end

  def test_transaction_attributes_can_be_updated
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    actual = transaction_repository.find_by_id(1)

    assert_equal transaction_repository.find_all_by_credit_card_number('4068631943231473'), [actual]

    id = (1)
    attributes = {credit_card_number: '5068631943231475'}

    transaction_repository.update(id, attributes)

    assert_equal '5068631943231475', transaction_repository.find_by_id(id).credit_card_number
  end

  def test_transaction_can_be_deleted
    transaction_repository = TransactionRepository.new('./data/transactions.csv')

    transaction_repository.delete(1)
    assert_nil transaction_repository.find_by_id(1)
  end
end
