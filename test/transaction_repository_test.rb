require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exits
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of TransactionRepository, tr
  end

  def test_all_returns_array_of_all_transactions_instances
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal 4985, tr.all.count
    assert_instance_of Transaction, tr.all[2]
  end

  def test_find_by_id_returns_nil_or_instance_of_transaction
    tr = TransactionRepository.new("./data/transactions.csv")

    transaction = tr.find_by_id(10)

    assert_equal 10, transaction.id
    assert_nil tr.find_by_id(6000)
  end

  def test_find_all_by_invoice_id
    tr = TransactionRepository.new("./data/transactions.csv")
    transaction = tr.find_all_by_invoice_id(2179)

    assert_equal 2, transaction.count
    assert_instance_of Transaction, transaction[0]
    assert_equal [], tr.find_all_by_invoice_id(100)
  end

  def test_that_delete_deletes_a_transaction
    tr = TransactionRepository.new("./data/transactions.csv")
    tr.delete(10)

    assert_nil tr.find_by_id(10)
  end

  def test_find_all_by_credit_card_number_finds_all_transactions
    tr = TransactionRepository.new("./data/transactions.csv")
    transaction = tr.find_all_by_credit_card_number("4848466917766329")

    assert_equal 1, transaction.count
    assert_instance_of Transaction, transaction[0]
    assert_equal "4848466917766329", transaction[0].credit_card_number
    assert_equal [], tr.find_all_by_credit_card_number("0000000000000")
  end

  def test_find_all_by_result_returns_all_transactions_with_given_result
    tr = TransactionRepository.new("./data/transactions.csv")
    failed_transactions = tr.find_all_by_result(:failed)
    successful_transactions = tr.find_all_by_result(:success)

    assert_equal 827, failed_transactions.count
    assert_equal 4158, successful_transactions.count
    assert_instance_of Transaction, successful_transactions[0]
  end

  def test_that_create_creates_a_new_transaction
    tr = TransactionRepository.new("./data/transactions.csv")
    tr.create({
              :invoice_id => 8,
              :credit_card_number => "4242424242424242",
              :credit_card_expiration_date => "0220",
              :result => "success",
              :created_at => Time.now,
              :updated_at => Time.now
            })
    new_transaction = tr.find_by_id(4986)

    assert_equal 8, new_transaction.invoice_id
    assert_equal "4242424242424242", new_transaction.credit_card_number
  end

  def test_that_update_updates_a_transaction
    tr = TransactionRepository.new("./data/transactions.csv")
    transaction = tr.find_by_id(1)
    old_transaction_time = transaction.updated_at

    attributes = {:credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "failed",}

    tr.update(1, attributes)

    assert_equal "4242424242424242", transaction.credit_card_number
    assert_equal "0220", transaction.credit_card_expiration_date
    assert_equal :failed, transaction.result
    assert old_transaction_time < transaction.updated_at
  end

end
