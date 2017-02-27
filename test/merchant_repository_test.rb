require_relative'test_helper'
require'./lib/merchant_repository'
require'./lib/sales_engine'

class MerchantRepoTest < Minitest::Test
	attr_reader :mr, :se

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./test/fixtures/items_reduced.csv",
			:merchants => "./test/fixtures/merchant_reduced.csv",
			:invoices => "./test/fixtures/invoices_reduced.csv",
			:invoice_items => "./test/fixtures/inv_items_reduced.csv",
			:transactions => "./test/fixtures/transactions_reduced.csv"
		})
		@mr = se.merchants
	end
	
	def test_can_find_all
		assert_equal 3, mr.all.count
	end

	def test_can_find_by_name
		assert_instance_of Merchant, mr.find_by_name("Madewithgitterxx")
	end

	def test_can_find_by_id
		assert_equal "Madewithgitterxx", mr.find_by_id("12334185").name
	end

	def test_can_find_all_by_name
		assert_equal 1, mr.find_all_by_name("Madewithgitterxx").count
		assert_equal [], mr.find_all_by_name("Craig")
	end
end