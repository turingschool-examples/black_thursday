require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @invoices = mock('invoices')
    @tr = TransactionRepository.new(@invoices)
    @tr.from_csv('./test/fixtures/transactions_truncated.csv')
  end

  def test_it_can_find_all_known_transactions
    transactions = @tr.all

    assert_equal 14, transactions.length
    assert transactions.all? do |transaction|
      transaction.class == Transaction
    end
  end

  def test_find_by_id_returns_a_transaction_with_a_matching_id
    transaction = @tr.find_by_id(234)

    assert_instance_of Transaction, transaction
    assert 234, transaction.id
  end

  def test_find_by_id_returns_an_nil_if_no_transaction_with_id
    assert_nil @tr.find_by_id(34)
  end

  def test_find_all_by_invoice_id_returns_all_transactions_with_matching_invoice_id
    transactions = @tr.find_all_by_invoice_id(7)

    assert_equal 3, transactions.length
    assert transactions.all? do |transaction|
      transaction.invoice_id == 3343 && transaction.class == Transaction
    end
  end

  def test_find_all_by_invoice_id_returns_empty_array_when_no_transaction_with_invoice_id
    transactions = @tr.find_all_by_invoice_id(56)

    assert transactions.empty?
  end

  def test_it_can_find_all_transactions_with_matching_credit_card_number
    credit_card_number = 4399131883281206
    transactions = @tr.find_all_by_credit_card_number(credit_card_number)

    assert_equal 3, transactions.length
    assert transactions.all? do |transaction|
      transaction.credit_card_number == credit_card_number && transaction.class == Transaction
    end
  end

  def test_it_returns_an_empty_array_if_no_transactions_match_credit_card_number
    transactions =  @tr.find_all_by_credit_card_number(44551332229987663)
    assert transactions.empty?
  end

  def test_find_all_by_result_finds_all_transactions_succesful_or_failed
    succesful_transactions = @tr.find_all_by_result('success')
    failed_transactions = @tr.find_all_by_result('failed')

    assert_equal 12, succesful_transactions.length
    assert succesful_transactions.all? do |transaction|
      transaction.result == 'success' && transaction.class == Transaction
    end

    assert_equal 2, failed_transactions.length
    assert failed_transactions.all? do |transaction|
      transaction.result == 'failed' && transaction.class == Transaction
    end
  end

  def test_find_all_by_result_returns_an_empty_array_if_no_transactions_match_result
    transactions = @tr.find_all_by_result('pending')

    assert transactions.empty?
  end
end
