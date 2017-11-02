require_relative 'test_helper'
require_relative './../lib/transaction'
require_relative './../lib/transaction_repository'
require_relative './../lib/sales_engine'
require "pry"

class TransactionTest < Minitest::Test

  attr_reader :engine, :repository, :transaction

  def setup
    @engine = SalesEngine.from_csv({
    items: "./test/fixtures/truncated_items.csv",
    merchants: "./test/fixtures/truncated_merchants.csv",
    transactions: "./test/fixtures/truncated_transactions"
                                  })

    @repository = TransactionRepository.new("./test/fixtures/truncated_transactions.csv", @engine)

    @transaction = Transaction.new({
    id: 6,
    invoice_id: 8,
    credit_card_number: "4242424242424242",
    credit_card_expiration_date: "0220",
    result: "success",
    created_at: "2010-03-30",
    updated_at: "2013-01-21"
                                    }, @repository)
  end

  def test_it_exists
    assert_instance_of Transaction, transaction
  end

  def test_attributes_return_correctly
    assert_equal 6, transaction.id
    assert_equal 8, transaction.invoice_id
    assert_equal "4242424242424242", transaction.credit_card_number
    assert_equal '0220', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal Time.parse("2010-03-30"), transaction.created_at
    assert_equal Time.parse("2013-01-21"), transaction.updated_at
  end

end
