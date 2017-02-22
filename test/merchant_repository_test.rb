require_relative'test_helper'
require'./lib/merchant_repository'
require'./lib/sales_engine'

class MerchantRepoTest < Minitest::Test
	attr_reader :mr, :se

	def setup
		@se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./test/fixtures/merchant_reduced.csv",})
		@mr = se.merchants
	end
	
	def test_can_find_all
		assert_equal 3, mr.all.count
	end

	def test_can_find_by_name
		assert_instance_of Merchant, mr.find_by_name("cardsbymarykate")
	end

	def test_can_find_by_id
		assert_instance_of Merchant, mr.find_by_id("12337411")
	end

	def test_can_find_all_by_name
		assert_equal 2, mr.find_all_by_name("cardsbymarykate").count
		assert_equal [], mr.find_all_by_name("Craig")
	end
end