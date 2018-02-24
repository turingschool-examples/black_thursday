require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    data = {
      id:                             6,
      invoice_id:                     8,
      credit_card_number:             "4242424242424242",
      credit_card_expiration_date:    "0220",
      result:                         "success",
      created_at:                     "2018-02-02 14:37:20 -0700",
      updated_at:                     "2018-02-02 14:37:20 -0700"
      }
    @transaction = Transaction.new(data)
  end

  def test_if_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_if_it_has_attributes
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal 4242424242424242, @transaction.credit_card_number
    assert_equal "0220", @transaction.credit_card_expiration_date
    assert_equal "success", @transaction.result
    assert @transaction.created_at.class == Time
    assert @transaction.updated_at.class == Time
  end

  def test_if_it_returns_invoice_based_on_invoice_id
    data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    sales_engine = SalesEngine.new(data)
    id = 1
    transaction = sales_engine.transactions.find_by_id(id)

    assert_instance_of Invoice, transaction.invoice
    assert transaction.invoice.class == Invoice
    assert transaction.invoice.customer_id == 433
    assert transaction.invoice.merchant_id == 12334633
    assert transaction.invoice.status == :returned
  end

end
