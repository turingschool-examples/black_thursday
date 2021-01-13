require 'pry'
require 'CSV'
require './test/test_helper'
require './lib/transaction_repo'
require './lib/transaction'


class TransactionRepoTest < Minitest::Test

  def setup
    @engine = "engine"
    @tr = TransactionRepository.new(@engine)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
    assert_equal "engine", @tr.engine
  end

  def test_make_transactions
    assert_equal 1, @tr.transactions[1].id
    assert_equal "4297222478855497", @tr.transactions[5].credit_card_number
    assert_equal :failed, @tr.transactions[9].result
  end

  def test_all
    assert_equal 4985, @tr.all.length
  end

  def test_find_by_id
    assert_equal 2179, @tr.find_by_id(1).invoice_id
    assert_equal 3560, @tr.find_by_id(14).invoice_id
    assert_nil @tr.find_by_id(500000)
  end

  def test_find_all_by_invoice_id
    assert_equal 2, @tr.find_all_by_invoice_id(2179).length
    assert_equal 2, @tr.find_all_by_invoice_id(46).length
    assert_equal [], @tr.find_all_by_invoice_id(0)
  end

  def test_find_all_by_credit_card_number
    assert_equal 1, @tr.find_all_by_credit_card_number("4068631943231473")[0].id
    assert_equal [], @tr.find_all_by_credit_card_number("1111111111")
  end

  def test_find_all_by_result
    assert_equal 4158, @tr.find_all_by_result(:success).length
    assert_equal 827, @tr.find_all_by_result(:failed).length
    assert_equal 0, @tr.find_all_by_result(:failure).length
  end

  def test_max_id
    assert_equal 4985, @tr.max_id
  end

  def test_create
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => 10,
        :updated_at => 10
      }
    @tr.create(attributes)
    assert_equal 4986, @tr.find_all_by_credit_card_number("4242424242424242")[0].id
  end

  def test_update
    attributes = ({credit_card_number: 12,
                      credit_card_expiration_date: 14,
                      created_at: "2012-02-26 20:56:56 UTC",
                      result: 2,
                      id: 10000})
    @tr.update(1, attributes)
    assert_equal 12, @tr.transactions[1].credit_card_number
    assert_equal 14, @tr.transactions[1].credit_card_expiration_date
    refute_equal 1, @tr.transactions[1].created_at
    assert_nil @tr.transactions[10000]
  end

  def test_delete
    @tr.delete(1)
    assert_nil @tr.transactions[1]
    assert_equal 4984, @tr.transactions.length
  end

  def test_transaction_successful
    transaction = Transaction.new(attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => 10,
        :updated_at => 10
      })
      tr = TransactionRepository.new(@engine)

    assert_equal :success, tr.successful_transactions.first.result
    assert_equal :success, tr.successful_transactions.last.result
    assert_equal Array, tr.successful_transactions_invoice_ids.class
    assert_equal Integer, tr.successful_transactions_invoice_ids.first.class
    assert_equal 2810, tr.successful_transactions_invoice_ids.count
  end
end
