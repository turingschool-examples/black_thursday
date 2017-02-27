require_relative 'test_helper'
require 'csv'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :tr

  def setup
    @tr = TransactionRepository.new
    tr.from_csv("./test/fixtures/transactions_test.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepository, tr
  end

  def test_it_knows_all_transactions
    assert_instance_of Array, tr.all
    assert_equal 10, tr.all.count
    assert_instance_of Transaction, tr.all.first
  end

  def test_it_can_find_one_by_id
    assert_equal 750, tr.find_by_id(3).invoice_id
    assert_nil tr.find_by_id(12)
  end

  def test_it_can_find_all_with_given_invoice_id
    assert_instance_of Array, tr.find_all_by_invoice_id(4966)
    assert_equal 2, tr.find_all_by_invoice_id(4966).count
    assert_instance_of Transaction, tr.find_all_by_invoice_id(4966).first
  end

  def test_it_can_find_all_by_credit_card_number
    assert_instance_of Array, tr.find_all_by_credit_card_number(4149654190362629)
    assert_equal 1, tr.find_all_by_credit_card_number(4149654190362629).count
    assert_equal 1752, tr.find_all_by_credit_card_number(4149654190362629).first.invoice_id
    assert_instance_of Transaction, tr.find_all_by_credit_card_number(4149654190362629).first
  end

  def test_it_knows_all_by_result
    assert_instance_of Array, tr.find_all_by_result("success")
    assert_equal 9, tr.find_all_by_result("success").count
    assert_equal 2179, tr.find_all_by_result("success").first.invoice_id
    assert_instance_of Transaction, tr.find_all_by_result("success").first
    assert_equal 1, tr.find_all_by_result("failed").count
  end

end
