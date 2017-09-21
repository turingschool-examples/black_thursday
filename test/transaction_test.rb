require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })
    se.items
    se.merchants
    se.invoice_items
    se.customers
    se.invoices
    @tr = se.transactions
  end

  def test_it_exists_and_with_attributes
    assert_instance_of Transaction, @tr.find_by_id(941)
    assert_equal 941, @tr.find_by_id(941).id
    assert_equal 74, @tr.find_by_id(941).invoice_id
    assert_equal 4988736743808526, @tr.find_by_id(941).credit_card_number
    assert_equal '0820', @tr.find_by_id(941).credit_card_expiration_date
    assert_equal 'success', @tr.find_by_id(941).result
    assert_equal Time.parse('2012-02-26 20:57:27 UTC'), @tr.find_by_id(941).created_at
    assert_equal Time.parse('2012-02-26 20:57:27 UTC'), @tr.find_by_id(941).updated_at
  end

  def test_it_can_be_connected_with_an_invoice
    transaction = @tr.find_by_id(941)
    assert_instance_of Invoice, transaction.invoice
  end

end
