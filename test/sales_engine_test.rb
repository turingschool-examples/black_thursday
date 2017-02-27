require_relative'test_helper'
require'./lib/sales_engine'
require'./lib/merchant'

class SalesEngineTest < Minitest::Test
	attr_reader :se

	def setup
		# @se = SalesEngine.from_csv({
		# 	:items => "./test/fixtures/items_reduced.csv",
		# 	:merchants => "./test/fixtures/merchant_reduced.csv",
		# 	:invoices => "./test/fixtures/invoices_reduced.csv",
		# 	:invoice_items => "./test/fixtures/inv_items_reduced.csv",
		# 	:transactions => "./test/fixtures/transactions_reduced.csv",
		# 	:customers => "./test/fixtures/customers_reduced.csv"
		# })
		@se = SalesEngine.from_csv({
			:items => "./data/items.csv",
			:merchants => "./data/merchants.csv",
			:invoices => "./data/invoices.csv",
			:invoice_items => "./data/invoice_items.csv",
			:transactions => "./data/transactions.csv",
			:customers => "./data/customers.csv"
		})
	end

  def test_hash_of_pathnames_can_be_passed_into_sales_engine
		ir = se.items
		mr = se.merchants
    assert_instance_of ItemRepository, ir
    assert_instance_of MerchantRepository, mr
  end

	def test_merchants_can_find_by_name_from_sales_engine
    mr = se.merchants
    merchant_1 = mr.find_by_name("Madewithgitterxx")

    assert_instance_of Merchant, merchant_1
		assert_equal 12334185, merchant_1.id
		assert_equal "Madewithgitterxx", merchant_1.name
	end

	def test_can_reutrn_all_items_related_to_invoice
		invoice = se.invoices.find_by_id(20)
		assert_equal [], invoice.items
	end
end