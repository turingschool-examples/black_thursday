require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test 
	attr_reader :se, :inv_repo
	def setup
		@se = SalesEngine.from_csv({
  	:items     => "./test/fixtures/item_fixtures.csv",
  	:merchants => "./test/fixtures/merchant_invoice_fixture.csv",
  	:invoices => "./test/fixtures/invoices_fixture.csv"
		})
		@inv_repo = se.invoices
	end

	def test_it_exists
		assert_equal InvoiceRepository, inv_repo.class
	end

	def test_invoices_hash_populates
		refute inv_repo.invoices.empty?
	end

	def test_all_method_returns_array_of_all_invoices
		assert_equal 67, inv_repo.all.count
		assert_equal Array, inv_repo.all.class
	end

	def test_find_by_id	
		assert_equal Invoice, inv_repo.find_by_id(12).class
		assert_nil inv_repo.find_by_id('bobcat')
	end

	def test_find_all_by_status
		assert_equal Array, inv_repo.find_all_by_status(:pending).class
		assert_equal Invoice, inv_repo.find_all_by_status(:shipped).first.class
		assert_equal :shipped, inv_repo.find_all_by_status(:shipped).first.status
		assert_equal [], inv_repo.find_all_by_status(:hamster)
	end

	def test_find_all_by_customer_id
		assert_equal Array, inv_repo.find_all_by_customer_id(3).class
		assert_equal Array, inv_repo.find_all_by_customer_id(6).class
		assert_equal Invoice, inv_repo.find_all_by_customer_id(6).first.class
		assert_equal [], inv_repo.find_all_by_customer_id(33333)
		assert_equal 3, inv_repo.find_all_by_customer_id(3).first.customer_id
	end

	def test_find_all_by_merchant_id
		assert_equal Array, inv_repo.find_all_by_merchant_id(12335150).class
		assert_equal Array, inv_repo.find_all_by_merchant_id(12334301).class
		assert_equal Invoice, inv_repo.find_all_by_merchant_id(12334301).first.class
		assert_equal Array.new, inv_repo.find_all_by_merchant_id(111111111)
		assert_equal 12335150, inv_repo.find_all_by_merchant_id(12335150).first.merchant_id
	end
end