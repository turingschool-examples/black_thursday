require 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transactions

  def setup
    parent = mock('parent')
    @transactions = TransactionRepository.new([
      {
        :id => 332211,
        :invoice_id => 12345,
        :credit_card_number => 1234567812345678,
        :credit_card_expiration_date => 0312,
        :result => "success",
        :created_at => "2017-11-03",
        :updated_at => "2017-11-04"
      },{
        :id => 443322,
        :invoice_id => 12345,
        :credit_card_number => 8765432187654321,
        :credit_card_expiration_date => 1111,
        :result => "failed",
        :created_at => "2010-11-01",
        :updated_at => "2017-12-02"
        }], parent)
  end

  def test_transaction_repository_initalizes_with_attributes
    assert_instance_of TransactionRepository, transactions
    assert_equal 2, transactions.transactions.count
    assert_instance_of Transaction, transactions.transactions.first
    assert_instance_of TransactionRepository, transactions.transactions.first.parent
  end

  def test_can_find_all_transactions
    assert_equal 2, transactions.all.count
  end

  def test_can_find_transaction_by_id
    transaction_1 = transactions.find_by_id(443322)
    transaction_2 = transactions.find_by_id(554433)

    assert_instance_of Transaction, transaction_1
    assert_equal 'failed', transaction_1.result
    assert_nil transaction_2
  end

  def test_can_find_all_by_invoice_id
    result = transactions.find_all_by_invoice_id(12345)

    assert_equal 2, result.count
    assert_instance_of Transaction, result.first
    assert_instance_of Transaction, result.last
  end

  def test_can_find_all_by_credit_card_number
    result = transactions.find_all_by_credit_card_number(1234567812345678)

    assert_equal 1, result.count
    assert_equal 1234567812345678, result.first.credit_card_number
    assert_instance_of Transaction, result.first
  end

  def test_can_find_all_by_result
    actual = transactions.find_all_by_result('failed')

    assert_equal 1, actual.count
    assert_equal 'failed', actual.first.result
  end

  def test_can_call_find_invoice_by_invoice_id
    transactions.parent.stubs(:find_invoice_by_invoice_id).with(12345).returns(true)

    assert transactions.find_invoice_by_invoice_id(12345)
  end
end
