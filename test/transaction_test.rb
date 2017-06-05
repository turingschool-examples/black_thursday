
require 'time'
require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({"id"          => '1',
                          "invoice_id"  => '11',
                   "credit_card_number" => "4242424242424242",
         "credit_card_expiration_date"  => '0220',
                          "result"      => "success",
                          "created_at"  => '1993-09-29 11:56:40 UTC',
                          "updated_at"  => '1993-09-29 11:56:40 UTC'
                         })
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test_3.csv',
              :invoices => './test/data/invoices_test.csv',
              :invoice_items => './test/data/invoice_items_test.csv',
              :transactions  => './test/data/transactions_test.csv',
              :customers     => './test/data/customers_test.csv'}

  end

  def test_if_class_creates

    assert_instance_of Transaction, @t
  end

  def test_default_attributes_and_format

    assert_equal 1, @t.id
    assert_equal 11, @t.invoice_id
    assert_equal 4242424242424242, @t.credit_card_number
    assert_equal "0220", @t.credit_card_expiration_date
    assert_equal "success", @t.result
    assert @t.created_at
    assert @t.updated_at
  end

  def test_invoice_returns_instance_of_invoice
    se = SalesEngine.from_csv(@files)
    transaction = se.transactions.find_by_id(10)

    actual = transaction.invoice
    expected = se.invoices.all[11]

    assert_equal expected, actual
  end
end
