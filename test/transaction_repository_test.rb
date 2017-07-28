require_relative '../lib/transaction_repository'
require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/sales_engine'
require 'csv'
require 'bigdecimal'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @tr = @se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_all_returns_array_of_all_transactions
    assert_instance_of Array, @tr.all
    assert_equal 50, @tr.all.count
  end

  def find_by_id
    assert_instance_of Transaction, @tr.find_by_id(6)
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @tr.find_all_by_invoice_id(2179)
    assert_equal 1, @tr.find_all_by_invoice_id(2179).count
  end

  def test_find_all_by_credit_card_number
    assert_instance_of Array, @tr.find_all_by_credit_card_number(4177816490204479)
    assert_equal 1, @tr.find_all_by_credit_card_number(4177816490204479).count
  end

  def test_find_all_by_result
    assert_instance_of Array, @tr.find_all_by_result("success")
    assert_equal 40, @tr.find_all_by_result("success").count
  end

end
