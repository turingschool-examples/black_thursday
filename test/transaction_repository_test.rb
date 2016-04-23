require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test

  attr_reader :tr

  def setup
    test_helper = TestHelper.new
    @tr = TransactionRepository.new(test_helper.transactions)
  end

  def test_it_returns_an_array_of_all_transactions
    assert_equal Array, tr.all.class
    assert_equal 3, tr.all.count
  end

  def test_it_can_find_by_transaction_id
    assert_equal 7, tr.find_by_id(7).id
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(10).count
    assert_equal [10, 10], invoice_ids_from_transactions(tr.find_all_by_invoice_id(10))
  end

  def test_it_can_find_all_instances_of_a_transaction_using_a_credit_card
    assert_equal [6666666666666666], credit_card_numbers_from_transactions(tr.find_all_by_credit_card_number(6666666666666666))
  end

  def test_it_can_find_all_by_result
    assert_equal 2, tr.find_all_by_result("success").count
    assert_equal "success, success", result_from_transactions(tr.find_all_by_result("success"))
  end

  private

    def invoice_ids_from_transactions(transactions)
      transactions.map do |transaction|
        transaction.invoice_id
      end
    end

    def credit_card_numbers_from_transactions(transactions)
      transactions.map do |transaction|
        transaction.credit_card_number
      end
    end

    def result_from_transactions(transactions)
      transactions.map do |transaction|
        transaction.result
      end.join (", ")
    end

end
