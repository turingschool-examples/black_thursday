require_relative'test_helper'
require'./lib/transaction_repository'
require'./lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
	attr_reader :se, :tr

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./test/fixtures/items_reduced.csv",
			:merchants => "./test/fixtures/merchant_reduced.csv",
			:invoices => "./test/fixtures/invoices_reduced.csv",
			:invoice_items => "./test/fixtures/inv_items_reduced.csv",
			:transactions => "./test/fixtures/transactions_reduced.csv"
		})
		@tr = se.transactions
	end

	def test_can_find_all
		assert_equal 15, tr.all.count
	end

	def test_can_find_by_id
		assert_instance_of Transaction, tr.find_by_id(2)
	end

	def test_can_find_all_by_invoice_id
		assert_equal 2, tr.find_all_by_invoice_id(1298).count
	end

	def test_can_find_all_by_credit_card_number
		assert_equal 3, tr.find_all_by_credit_card_number(4839506591130477).count
	end

	def test_can_find_all_by_result
		assert_equal 13, tr.find_all_by_result("success").count
		assert_equal 2, tr.find_all_by_result("failed").count
	end
end