require_relative 'test_helper'
require_relative '../lib/transaction_repo'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv", :invoice_items => "./test/fixtures/invoice_items_fixture.csv", :transactions => "./test/fixtures/transactions_fixture.csv", :customers => "./test/fixtures/customers_fixture.csv"})
    SalesEngine.from_csv(files).invoices
  end

  def test_transaction_repo_exists
    assert_instance_of TransactionRepository, set_up.transactions
  end

  def test_all_transactions
    assert_equal 20, set_up.all.count
  end

  def test_find_by_id
    assert_nil set_up.find_by_id(1)
  end

  def test_find_all_by_credit_card_number
    assert_instance_of 1, set_up.find_by_id(4068631943231470).count
  end


end
