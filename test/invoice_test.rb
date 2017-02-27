require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice'

class ItemTest < Minitest::Test
	attr_reader :invoice
	def setup
		@invoice = Invoice.new({:id => "12".to_i, :customer_id => "3".to_i, :status => "pending".to_sym,
		:created_at => Time.parse("2007-06-04 21:35:10 UTC"), :updated_at => Time.parse("2016-01-11 09:34:06 UTC"), 
		:merchant_id => "12335955".to_i}, nil)
	end

	def test_invoice_info_exists
		expected = {:id => "12".to_i, :customer_id => "3".to_i, :status => "pending".to_sym,
		:updated_at => Time.parse("2016-01-11 09:34:06 UTC"), 
		:created_at => Time.parse("2007-06-04 21:35:10 UTC"), :merchant_id => "12335955".to_i }
		
		assert_equal expected, invoice.invoice_info
	end

	def test_invoice_instance_exists
		assert_nil invoice.inv_parent
	end

	def test_instance_of_invoice
		assert_equal Invoice, invoice.class
	end

	def test_invoice_has_an_id
		assert_equal 12, invoice.id
	end

	def test_invoice_can_have_a_status
		expected = :pending
		assert_equal expected, invoice.status
	end

	def test_invoice_has_a_created_at
		expected = Time.parse("2007-06-04 21:35:10 UTC")
		assert_equal expected, invoice.created_at
	end

	def test_invoice_has_a_updated_at
		expected = Time.parse("2016-01-11 09:34:06 UTC")
		assert_equal expected, invoice.updated_at
	end

	def test_invoice_has_a_merchant_id
		assert_equal 12335955, invoice.merchant_id
	end

	def test_invoice_merchant_connection
		#requires all se, item, instances
		skip
		assert_equal Merchant, invoice.merchant.class
	end
end
