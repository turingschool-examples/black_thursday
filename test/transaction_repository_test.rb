require_relative 'test_helper'
require './lib/transaction_repository'

class TestTransactionRepository < Minitest::Test

  def setup
    @loaded_file = [{id: 1 ,invoice_id: 10, credit_card_number: '4068631943231473', credit_card_expiration_date: '0217', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 2 ,invoice_id: 11, credit_card_number: '4068631943231474', credit_card_expiration_date: '0218', result: 'failed', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 3 ,invoice_id: 12, credit_card_number: '4068631943231475', credit_card_expiration_date: '0219', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 4 ,invoice_id: 13, credit_card_number: '4068631943231476', credit_card_expiration_date: '0317', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 5 ,invoice_id: 14, credit_card_number: '4068631943231477', credit_card_expiration_date: '0417', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 6 ,invoice_id: 15, credit_card_number: '4068631943231478', credit_card_expiration_date: '0517', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 7 ,invoice_id: 16, credit_card_number: '4068631943231479', credit_card_expiration_date: '0617', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 8 ,invoice_id: 17, credit_card_number: '4068631943231483', credit_card_expiration_date: '0717', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 9 ,invoice_id: 18, credit_card_number: '4068631943231493', credit_card_expiration_date: '0817', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 10 ,invoice_id: 19, credit_card_number: '4068631943231463', credit_card_expiration_date: '0917', result: 'failed', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 11 ,invoice_id: 20, credit_card_number: '4068631943231453', credit_card_expiration_date: '1017', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 12 ,invoice_id: 20, credit_card_number: '4068631943231443', credit_card_expiration_date: '1117', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 13 ,invoice_id: 22, credit_card_number: '4068631943231433', credit_card_expiration_date: '1217', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 14 ,invoice_id: 23, credit_card_number: '4068631943231423', credit_card_expiration_date: '0318', result: 'failed', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 15 ,invoice_id: 24, credit_card_number: '4068631943231413', credit_card_expiration_date: '0418', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 16 ,invoice_id: 25, credit_card_number: '4068631943231173', credit_card_expiration_date: '0518', result: 'failed', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 17 ,invoice_id: 36, credit_card_number: '4068631943231273', credit_card_expiration_date: '0619', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 18 ,invoice_id: 27, credit_card_number: '4068631943231373', credit_card_expiration_date: '0718', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 19 ,invoice_id: 28, credit_card_number: '4068631943231473', credit_card_expiration_date: '0818', result: 'failed', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'},
                    {id: 20 ,invoice_id: 29, credit_card_number: '4068631943231573', credit_card_expiration_date: '0918', result: 'success', created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'}]
    @tr = TransactionRepository.new(@loaded_file)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_returns_all_transactions
    assert_equal 20, @tr.all.count
  end

  def test_it_returns_transaction_matching_given_id
     transaction = @tr.find_by_id(2)

     assert_equal 2, transaction.id
     assert_equal Transaction, transaction.class
  end

  def test_it_returns_all_transactions_matching_given_id
     transactions = @tr.find_all_by_invoice_id(20)

     assert_equal 2, transactions.length
     assert_equal Transaction, transactions.first.class

     transactions = @tr.find_all_by_invoice_id(100)
     assert_equal true, transactions.empty?
  end

  def test_it_finds_transaction_by_credit_card_number
    transactions = @tr.find_all_by_credit_card_number("4068631943231474")

    assert_equal 1, transactions.length
    assert_equal Transaction, transactions.first.class

    assert_equal "4068631943231474", transactions.first.credit_card_number

    credit_card_number = "4848466917766328"
    transactions = @tr.find_all_by_credit_card_number(credit_card_number)

    assert transactions.empty?
  end

  def test_it_returns_all_transactions_matching_given_result
      transactions = @tr.find_all_by_result(:success)

      assert_equal 15, transactions.length
      assert_equal Transaction, transactions.first.class

      assert_equal :success, transactions.first.result

      transactions = @tr.find_all_by_result(:failed)

      assert_equal 5, transactions.length
      assert_equal Transaction, transactions.first.class
      assert_equal :failed, transactions.first.result
  end

  def test_it_creates_a_new_transaction_instance
      attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
      @tr.create(attributes)
      transaction = @tr.find_by_id(21)
      assert_equal 8, transaction.invoice_id
  end

  def test_it_can_update_a_transaction
      original_time = @tr.find_by_id(20).updated_at
      attributes = {
        result: :failed
      }
      @tr.update(20, attributes)
      transaction = @tr.find_by_id(20)
      assert_equal :failed, transaction.result
      assert_equal "0918", transaction.credit_card_expiration_date
      assert transaction.updated_at > original_time
  end

  def test_it_deletes_the_specified_transaction
      @tr.delete(19)
      assert_nil @tr.find_by_id(19)
  end

end
