require_relative 'test_helper'
require 'time'
require_relative "../lib/transaction"
require_relative "../lib/sales_engine"


class TransactionTest < Minitest::Test

  attr_reader :transaction

  def setup
    transaction_data = {
      :id                 => "1",
      :invoice_id         => "2179",
      :credit_card_number => "4068631943231473",
      :result             => "success",
      :created_at         => "2018-01-02 14:37:20 -0700",
      :updated_at         => "2018-01-02 14:37:25 -0700"}
    parent = mock('repository')
    @transaction = Transaction.new(transaction_data, parent)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 1, @transaction.id
    assert_equal 2179, @transaction.invoice_id
    assert_equal 4068631943231473, @transaction.credit_card_number
    assert_equal "success", @transaction.result
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @transaction.created_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @transaction.updated_at
  end

  def test_returns_invoice_item_by_id
    invoice_1 = mock("2179")
    invoice_2 = mock("4126")
    invoice_3 = mock("290")

    transaction.transaction_repo.stubs(:find_invoice_by_id).returns([invoice_1, invoice_2, invoice_3])

    assert_equal [invoice_1, invoice_2, invoice_3], transaction.invoice
    assert_equal 3, transaction.invoice.count
    assert_equal invoice_3, transaction.invoice.last
  end

end
