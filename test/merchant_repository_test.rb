require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test 
	attr_reader :se, :mr
	def setup
		@se = SalesEngine.from_csv({
  	:items     => "./data/items.csv",
  	:merchants => "./data/merchants.csv",
		})
		@mr = se.merchants
	end
	def test_that_merchant_maker_returns_sthg
		# refute mr.merchants.empty?
		# binding.pry
		assert_equal nil, mr.merchant_maker
	end


end