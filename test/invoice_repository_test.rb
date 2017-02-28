require_relative'test_helper'
require'./lib/invoice_repository'
require'./lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
	attr_reader :se, :invoices

	def setup
		@se = SalesEngine.from_csv({
			:items         => "./test/fixtures/items_reduced.csv",
			:merchants     => "./test/fixtures/merchant_reduced.csv",
			:invoices      => "./test/fixtures/invoices_reduced.csv",
			:invoice_items => "./test/fixtures/inv_items_reduced.csv",
			:transactions  => "./test/fixtures/transactions_reduced.csv",
			:customers     => "./test/fixtures/customers_reduced.csv"
		})
		@invoices = se.invoices
	end

	def test_can_find_by_id
		assert_instance_of Invoice, invoices.find_by_id(6)
		assert_equal 6, invoices.find_by_id(6).id
		assert_equal 12334389, invoices.find_by_id(6).merchant_id
	end

	def	test_can_find_all_by_customer_id
		assert_instance_of Array, invoices.find_all_by_customer_id(6)
		assert_equal 24, invoices.find_all_by_customer_id(6)[0].id
		assert_equal 12335938, invoices.find_all_by_customer_id(1)[0].merchant_id
	end
end