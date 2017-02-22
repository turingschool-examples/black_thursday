require_relative'test_helper'
require'./lib/merchant'

class MerchantTest < Minitest::Test
	attr_reader :m

	def setup
		@m = Merchant.new({:id => 5, :name => "Turing School"}, nil)
	end

	def test_can_make_new_merchant
		assert_instance_of Merchant, m
	end

	def test_return_id
		assert_equal 5, m.id
	end

	def test_return_name
		assert_equal "Turing School", m.name
	end
end