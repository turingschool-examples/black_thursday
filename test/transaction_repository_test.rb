require_relative 'test_helper'
require_relative '../lib/transaction_repository.rb'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repository
  end

  def test_it_can_hold_transactions
    assert_instance_of Array, @transaction_repository.transactions
  end

  def test_its_holding_transactions
    assert_instance_of Transaction, @transaction_repository.transactions[0]
    assert_instance_of Transaction, @transaction_repository.transactions[25]
  end

  def test_it_can_return_transactions_using_all
    assert_instance_of Transaction, @transaction_repository.all[5]
    assert_instance_of Transaction, @transaction_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @transaction_repository.transactions[0]
    actual = @transaction_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_invoice_id
    expected = 2
    actual = @transaction_repository.find_all_by_invoice_id(2179).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_credit_card_number
    expected = 1
    actual = @transaction_repository.find_all_by_credit_card_number("4068631943231473").count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_result
    expected = 4158
    actual = @transaction_repository.find_all_by_result("success").count
    assert_equal expected, actual
  end

  def test_it_create_new_transaction_with_attributes
    new_transaction_added = @transaction_repository.create({
      invoice_id: "99999999",
      credit_card_number: "4646464675757575",
      credit_card_expiration_date: "0823",
      result: "failed"
      })
    expected = @transaction_repository.transactions[-1]
    actual = new_transaction_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    @transaction_repository.create({
      invoice_id: "99999999",
      credit_card_number: "4646464675757575",
      credit_card_expiration_date: "1123",
      result: "failed"
      })
    new_transaction = @transaction_repository.transactions.last

    last_transaction_credit_card_number = new_transaction.credit_card_number
    last_transaction_credit_card_expiration_date = new_transaction.credit_card_expiration_date
    last_transaction_result = new_transaction.result

    assert_equal "4646464675757575", last_transaction_credit_card_number
    assert_equal "1123", last_transaction_credit_card_expiration_date
    assert_equal :failed, last_transaction_result

    @transaction_repository.update(4986, {
      credit_card_number: "4646464692929292",
      credit_card_expiration_date: "1205",
      result: "success"
      })
    changed_transaction = @transaction_repository.transactions.last

    assert_equal "4646464692929292", changed_transaction.credit_card_number
    assert_equal "1205", changed_transaction.credit_card_expiration_date
    assert_equal :success, changed_transaction.result

    assert_equal new_transaction.id, changed_transaction.id
  end

  def test_it_can_delete_transaction
    assert_equal @transaction_repository.transactions[0], @transaction_repository.find_by_id(1)

    @transaction_repository.delete("1")
    assert_nil @transaction_repository.find_by_id("1")
  end
end
