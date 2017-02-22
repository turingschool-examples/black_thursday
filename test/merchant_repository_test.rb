require_relative'test_helper'
require'./lib/merchant_repository'
require'./lib/sales_engine'

class MerchantRepoTest < Minitest::Test
	attr_reader :mr, :se

	def setup
		@se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv",})
		@mr = se.merchants
	end

	def test_can_find_all
		assert_equal [], mr.all
		binding.pry
		merchant_2 = mr.find_by_name("Shopin1901")
		merchant_1 = mr.find_by_name("CJsDecor")
		mr.add_merchant(merchant_1, se)

		assert_equal 1, mr.all.count

		mr.add_merchant(merchant_2, se)
		assert_equal 2, mr.all.count
	end

	def test_can_find_by_id
		skip

	end

	def test_can_find_by_name
		skip

	end

	def test_can_find_all_by_name
		skip

	end
end

# all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive