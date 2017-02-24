require_relative'test_helper'
require'./lib/invoice_repository'
require'./lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
	attr_reader :se, :invoices

	def setup
		@se = SalesEngine.from_csv({:items => "./test/fixtures/items_reduced.csv", :merchants => "./test/fixtures/merchant_reduced.csv", :invoices => "./test/fixtures/invoices_reduced.csv"})
		@invoices = se.invoices
	end

	def test_can_find_by_id
		assert_instance_of Invoice, invoices.find_by_id(6)
		assert_equal 6, invoices.find_by_id(6).id
		assert_equal 12334389, invoices.find_by_id(6).merchant_id
	end

	def	test_can_find_all_by_customer_id
		skip
		assert_instance_of Invoice, invoices.find_all_by_customer_id(6)
		assert_equal 6, invoices.find_all_by_customer_id(6).id
		assert_equal 62334389, invoices.find_all_by_customer_id(1).merchant_id
	end
end

# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status