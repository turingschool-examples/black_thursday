require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant'

class MerchantTest < Minitest::Test 
	attr_reader :merchant
	def setup
		@merchant = Merchant.new({:id => 12334112, :name => 'Candisart'}, nil)
	end

	def test_merchant_info_exists
		expected = {:id => 12334112, :name => 'Candisart'}
		assert_equal expected, merchant.merchant_info
	end

	def test_merchant_instance_exists
		assert_nil merchant.mr_instance
	end

	def test_instance_of_merchant
		assert_equal Merchant, merchant.class
	end

	def test_merchant_has_a_name
		assert_equal 'Candisart', merchant.name
	end

	def test_merchant_has_an_id
		assert_equal 12334112, merchant.id
	end
end