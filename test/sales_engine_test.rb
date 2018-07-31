require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repository'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/transactions.csv",
    :invoice_items => "./data/invoice_items.csv"
     })
    assert_instance_of SalesEngine, sales_engine
  end
end
