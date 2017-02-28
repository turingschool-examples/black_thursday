require './test/test_helper'
require './lib/transaction'
require './lib/sales_engine'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({
            :id=>"1",
            :invoice_id=>"2179",
            :credit_card_number=>"4068631943231473",
            :credit_card_expiration_date=>"0217",
            :result=>"success",
            :created_at=>"2012-02-26 20:56:56 UTC",
            :updated_at=>"2012-02-26 20:56:56 UTC"
            })
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :transactions => "./data/transactions.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"
      })

    @tr = se.transactions
  end

  def test_transaction_properties
    assert_instance_of Transaction, @t
    assert_equal 2179, @t.invoice_id
    assert_equal "0217", @t.credit_card_expiration_date
    assert_equal 4068631943231473, @t.credit_card_number
    assert_equal "success", @t.result
    assert_instance_of Time, @t.created_at
    assert_instance_of Time, @t.updated_at
  end

  def test_transaction_has_invoice
    transaction = @tr.find_by_id(40)
    assert_instance_of Invoice, transaction.invoice
  end


end
