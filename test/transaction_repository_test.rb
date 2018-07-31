require "minitest/autorun"
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
class TransactionRepositoryTest < Minitest::Test
  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv",
      :transactions =>"./data/dummy_transactions.csv" })
      @tr = TransactionRepository.new(@se.csv_hash[:transactions])
      @tr.create_transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_all
    assert_equal 10 , @tr.all.count
  end
  def test_you_can_find_by_id
    transaction = @tr.find_by_id(8)
    assert_equal 8, transaction.id
  end
end
