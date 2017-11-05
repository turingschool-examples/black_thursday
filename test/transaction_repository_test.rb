require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @transactions = @sales_engine.transactions
  end

  def test_that_it_finds_all_transactions
    assert_equal @transactions.transactions, @transactions.all
  end

end
