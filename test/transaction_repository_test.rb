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

  def test_can_find_all_by_invoice_id(id)
    result = @tr.test_can_find_all_by_invoice_id 2779

    assert_instance_of Array, result


end
