require_relative'test_helper'
require'./lib/customer_repository'
require'./lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
	attr_reader :se, :cr

	def setup
		@se = SalesEngine.from_csv({
			:items         => "./test/fixtures/items_reduced.csv",
			:merchants     => "./test/fixtures/merchant_reduced.csv",
			:invoices      => "./test/fixtures/invoices_reduced.csv",
			:invoice_items => "./test/fixtures/inv_items_reduced.csv",
			:transactions  => "./test/fixtures/transactions_reduced.csv",
			:customers     => "./test/fixtures/customers_reduced.csv"
		})
		@cr = se.customers
	end

	def test_can_find_all
		assert_equal 15, cr.all.count
	end

	def test_can_find_by_id
		assert_equal "Ilene", cr.find_by_id(12).first_name
	end

	def test_can_find_all_by_first_name_case_insensitive
		assert_equal 1, cr.find_all_by_first_name("IlEne").count
	end

	def test_can_find_all_by_last_name_case_insensitive
		assert_equal 1, cr.find_all_by_last_name("conSidine").count
	end
end