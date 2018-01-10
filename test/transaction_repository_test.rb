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

    all_transactions = transactions.all? do |transaction|
      transaction.class == Transaction
    end

    assert_equal 38, transactions.length
    assert all_transactions
  end

  def test_find_by_id_returns_a_transaction_with_a_matching_id
    transaction = @tr.find_by_id(1)

    assert_instance_of Transaction, transaction
    assert 1, transaction.id
  end

  def test_find_by_id_returns_an_nil_if_no_transaction_with_id
    assert_nil @tr.find_by_id(34)
  end

  def test_find_all_by_invoice_id_returns_all_transactions_with_matching_invoice_id
    transactions = @tr.find_all_by_invoice_id(7)

    all_match_invoice_id = transactions.all? do |transaction|
      transaction.invoice_id == 7 && transaction.class == Transaction
    end

    assert_equal 2, transactions.length
    assert all_match_invoice_id
  end

  def test_find_all_by_invoice_id_returns_empty_array_when_no_transaction_with_invoice_id
    transactions = @tr.find_all_by_invoice_id(56)

    assert transactions.empty?
  end

  def test_it_can_find_all_transactions_with_matching_credit_card_number
    credit_card_number = 4399131883281206
    transactions = @tr.find_all_by_credit_card_number(credit_card_number)

    all_match_card_number = transactions.all? do |transaction|
      transaction.credit_card_number == credit_card_number && transaction.class == Transaction
    end

    assert_equal 3, transactions.length
    assert all_match_card_number
  end

  def test_it_returns_an_empty_array_if_no_transactions_match_credit_card_number
    transactions =  @tr.find_all_by_credit_card_number(44551332229987663)
    assert transactions.empty?
  end

  def test_find_all_by_result_finds_all_transactions_succesful_or_failed
    succesful_transactions = @tr.find_all_by_result('success')
    failed_transactions = @tr.find_all_by_result('failed')

    all_succesful = succesful_transactions.all? do |transaction|
      transaction.result == 'success' && transaction.class == Transaction
    end
    all_failed = failed_transactions.all? do |transaction|
      transaction.result == 'failed' && transaction.class == Transaction
    end

    assert_equal 29, succesful_transactions.length
    assert all_succesful
    assert_equal 9, failed_transactions.length
    assert all_failed
  end

  def test_find_all_by_result_returns_an_empty_array_if_no_transactions_match_result
    transactions = @tr.find_all_by_result('pending')

    assert transactions.empty?
  end

  def test_it_calls_its_parent_to_find_invoice_by_invoice_id
    invoice = mock('invoice')
    @invoices.expects(:find_by_id).returns(invoice)

    assert_equal invoice, @tr.find_invoice_by_invoice_id(3)
  end
end
