require_relative'test_helper'
require'./lib/invoice_item_repository'
require'./lib/invoice_item'
require'./lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
	attr_reader :iir, :se

	def	setup 
		@se = SalesEngine.from_csv({:items => "./test/fixtures/items_reduced.csv", :merchants => "./test/fixtures/merchant_reduced.csv", :invoices => "./test/fixtures/invoices_reduced.csv", :invoice_items => "./test/fixtures/inv_items_reduced.csv"})
		@iir = se.invoice_items
	end

	def test_all
		assert_equal 14, iir.all.count
	end

	def test_find_by_id
		assert_equal 4, iir.find_by_id(13).quantity
	end

	def test_find_all_by_item_id
		assert_equal 2, iir.find_all_by_item_id(263529264).count
	end

	def test_find_all_by_invoice_id
		assert_equal 8, iir.find_all_by_invoice_id(1).count
	end
end