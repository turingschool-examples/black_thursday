require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'

class TransactionTest < Minitest::Test
  def setup
    @data = {
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'success',
      created_at: '2012-02-26 20:56:56 UTC',
      updated_at: '2012-02-26 20:56:56 UTC'
    }
    @transaction = Transaction.new(@data, 'TransactionRepo pointer')
  end

  def information
    {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_initializes_with_information_1
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal 424_242_424_242_424_2, @transaction.credit_card_number
    assert_equal '0220', @transaction.credit_card_expiration_date
  end

  def test_initializes_with_information_2
    assert_equal 'success', @transaction.result
    assert_equal Time.utc(2012, 0o2, 26, 20, 56, 56), @transaction.created_at
    assert_equal Time.utc(2012, 0o2, 26, 20, 56, 56), @transaction.updated_at
    assert_equal 'TransactionRepo pointer', @transaction.parent
  end

  def test_item_attributes_have_correct_class
    assert_instance_of Time, @transaction.created_at
    assert_instance_of Time, @transaction.updated_at
  end

  def test_finding_invoice_associated_with_transaction
    sales_engine = SalesEngine.from_csv(information)
    transaction = sales_engine.transactions.find_by_id(20)

    assert_instance_of Invoice, transaction.invoice
    assert_equal 2668, transaction.invoice.id
  end
end
