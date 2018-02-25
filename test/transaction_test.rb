require_relative 'test_helper'
require_relative '../lib/transaction'

# test for transaction class
class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(id: 6,
                                   invoice_id: 8,
                                   credit_card_number: '4242424242424242',
                                   credit_card_expiration_date: '0220',
                                   result: 'success',
                                   created_at: Time.now,
                                   updated_at: Time.now)
  end

  def test_class_can_be_instantiated
    assert_instance_of Transaction, @transaction
  end

  def test_class_has_attributes_from_data
    assert_equal 6,                @transaction.id
    assert_equal 8,                @transaction.invoice_id
    assert_equal 4242424242424242, @transaction.credit_card_number
    assert_equal '0220',           @transaction.credit_card_expiration_date
    assert_equal 'success',        @transaction.result
    assert_instance_of Time,       @transaction.created_at
    assert_instance_of Time,       @transaction.updated_at
  end

  def test_it_can_get_invoice
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/customers.csv')

    transaction = se.transactions.find_by_id(3)
    assert_instance_of Invoice, transaction.invoice
    assert_equal 1,             transaction.invoice.id
  end
end
