require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path,
                  :transactions => transaction_path
                }
    @se = SalesEngine.from_csv(arguments)
    @tr = @se.transactions
  end

  def test_all_returns_all_transactions
    expected = @tr.all
    assert_equal 4985, expected.count
  end
end 
