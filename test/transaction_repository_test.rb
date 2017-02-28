require './test/test_helper'
require './lib/transaction_repository'
require './lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  @@se = SalesEngine.from_csv({
    :invoices => "./data/invoices.csv",
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :transactions => "./data/transactions.csv"
    })

    def setup
      @se = @@se
      @tr = @@se.transactions
    end

    def test_it_exists
      assert_instance_of TransactionRepository, @tr
    end

    def test_all
      assert_equal 4985, @tr.all.count
    end

    def test_find_by_id
      assert_equal 4297222478855497, @tr.find_by_id(5).credit_card_number
    end

    def test_find_all_by_invoice_id
      result = @tr.find_all_by_invoice_id(3715)
      assert_equal 1, result.count
    end

    def test_find_all_by_credit_card_number
      result = @tr.find_all_by_credit_card_number(4297222478855497)
      assert_equal 1, result.count
    end

    def test_find_all_by_result
      result = @tr.find_all_by_result("success")
      assert_equal 4158, result.count
    end



end
