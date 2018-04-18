require 'time'
require_relative 'test_helper'
require './lib/transaction_repository'
require './lib/sales_engine'
require 'pry'

# transaction repo test
class TransactionRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      {
        items:         './test/fixtures/items_truncated.csv',
        merchants:     './test/fixtures/merchants_truncated.csv',
        invoices:      './test/fixtures/invoices_truncated.csv',
        invoice_items: './test/fixtures/invoice_items_truncated.csv',
        transactions:  './test/fixtures/transactions_truncated.csv',
        customers:     './test/fixtures/customers_truncated.csv'
      } )

    @t = @se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @t
  end

  def test_it_has_items
    assert_equal 10, @t.all.count
    assert_instance_of Array, @t.all
  end

  def test_find_by_id
    assert_instance_of Transaction, @t.find_by_id(1)
  end

  def test_find_all_by_invoice_id
    assert_nil @t.find_by_id(777)
    assert_instance_of Array, @t.find_all_by_invoice_id(1)
  end

  def test_find_all_by_credit_card_number
    actual = @t.find_all_by_credit_card_number('4068631943231473')

    assert_instance_of Array, actual
    assert_equal 1, actual.count
  end

  def test_find_all_by_result
    actual = @t.find_all_by_result(:success)

    assert_instance_of Array, actual
    assert_equal 9, actual.count
  end

  def test_create_transaction
    assert_equal 10, @t.transactions.last.id

    attributes = ({
      id:  6,
      invoice_id:  8,
      credit_card_number:  '4242424242424242',
      credit_card_expiration_date:  "0220",
      result:  'success',
      created_at:  Time.now,
      updated_at:  Time.now
                  })

    @t.create(attributes)

    actual = @t.transactions.last

    assert_equal 11, actual.id
    assert_equal 8, actual.invoice_id
    assert_equal '4242424242424242', actual.credit_card_number
    assert_equal :success, actual.result
  end

  def test_update_transaction
    attributes = ({
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'failed',
      created_at: Time.now,
      updated_at: Time.now

                   })

    to_update = @t.find_by_id(10)

    assert_equal '4149654190362629', to_update.credit_card_number
    assert_equal '0420', to_update.credit_card_expiration_date
    assert_equal :success, to_update.result

    @t.update(10, attributes)

    assert_equal '4242424242424242', to_update.credit_card_number
    assert_equal '0220', to_update.credit_card_expiration_date
    assert_equal :failed, to_update.result
  end

  def test_delete_item
    actual = @t.transactions

    assert_equal 10, actual.count

    @t.delete(1)

    assert_nil @t.find_by_id(1)
    assert_equal 9, actual.count
  end
end
