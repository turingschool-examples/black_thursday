require './test/test_helper'
require './lib/invoice'

class MerchantTest < Minitest::Test

	def setup
		@invoice = Invoice.new({
			:id          => 6,
			:customer_id => 7,
			:merchant_id => 8,
			:status      => "pending",
			:created_at  => Time.now,
			:updated_at  => Time.now,
														})
  end

	def test_it_exists
		assert_instance_of Invoice, @invoice 
	end

	def test_it_returns_integer_id
		assert_equal 6, @invoice.id
	end

	def test_it_returns_customer_id
		assert_equal 7, @invoice.customer_id
	end 

end 