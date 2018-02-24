# frozen_string_literal: true

require_relative 'test_helper'

require_relative '../lib/transaction.rb'
require_relative '../lib/sales_engine'
require_relative 'mocks/test_engine'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @tr = TransactionRepository.new './test/fixtures/transactions.csv',
                                    MOCK_SALES_ENGINE
  end

  def test_creates_transaction_repository
    assert_instance_of TransactionRepository, @tr
  end

  def test_did_load_items
    transactions = @tr.all
    assert_instance_of Array, transactions
    transactions.each do |transaction|
      assert_instance_of Transaction, transaction
    end

    assert_equal '4177816490204479', transactions[1].credit_card_number
    assert_equal '4297222478855497', transactions[4].credit_card_number
  end

  def test_can_find_by_transaction_id
    transaction = @tr.find_by_id 1
    assert_instance_of Transaction, transaction
    assert_equal 2179, transaction.invoice_id
  end

  def test_can_find_all_by_invoice_id
    result = @tr.find_all_by_invoice_id 2179

    assert_instance_of Array, result
    assert_instance_of Transaction, result[0]
    assert_instance_of Transaction, result[1]
    assert_equal '4068631943231473', result[0].credit_card_number
    assert_equal '4318767847968505', result[1].credit_card_number
  end

  def test_empty_invoice_id_array_returns_when_no_match
    result = @tr.find_all_by_invoice_id '_____'

    assert_instance_of Array, result
    assert result.empty?
  end

  def test_can_find_all_by_credit_card_number
    result = @tr.find_all_by_credit_card_number '4518913442963142'

    assert_instance_of Array, result
    assert_instance_of Transaction, result[0]
    assert_instance_of Transaction, result[1]
    assert_equal 2747, result[0].invoice_id
    assert_equal 3560, result[1].invoice_id
  end

  def test_empty_credit_card_array_returns_when_no_match
    result = @tr.find_all_by_credit_card_number '0123012301230123'

    assert_instance_of Array, result
    assert result.empty?
  end

  def test_can_find_all_by_result
    result = @tr.find_all_by_result 'failed'

    assert_instance_of Array, result
    assert_instance_of Transaction, result[0]
    assert_instance_of Transaction, result[1]
    assert_equal 1752, result[0].invoice_id
    assert_equal 3560, result[1].invoice_id
  end

  def test_empty_credit_result_array_returns_when_no_match
    result = @tr.find_all_by_result '_______'

    assert_instance_of Array, result
    assert result.empty?
  end
end
