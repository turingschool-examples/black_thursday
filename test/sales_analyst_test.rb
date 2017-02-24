require_relative'test_helper'
require'./lib/sales_engine'
require'./lib/merchant'
require'./lib/sales_analyst'

class SalesEngineTest < Minitest::Test
	attr_reader :se, :sa

	def setup
		@se = SalesEngine.from_csv({
			:items     => "./test/fixtures/items_reduced.csv",
			:merchants => "./test/fixtures/merchant_reduced.csv",
		})
		@sa = SalesAnalyst.new(se)
	end

  def test_hash_of_pathnames_can_be_passed_into_sales_engine
		ir = se.items
		mr = se.merchants
    assert_instance_of ItemRepository, ir
    assert_instance_of MerchantRepository, mr
  end

	def test_merchants_can_find_by_name_from_sales_engine
    mr = se.merchants
    merchant_1 = mr.find_by_name("Shopin1901")

    assert_instance_of Merchant, merchant_1
		assert_equal 12334105, merchant_1.id
		assert_equal "Shopin1901", merchant_1.name
	end

	def test_merchant_and_items_communicate
		merchant = se.merchants.find_by_id("12334185")
		assert_equal 2, merchant.items.count
		item = se.items.find_by_id(263395617)
		assert_instance_of Merchant, item.merchant
		assert_equal 12334185, item.merchant.id
		assert_equal "Madewithgitterxx", item.merchant.name
	end

	def test_sales_analyst_exists
		assert_instance_of SalesAnalyst, sa
	end

	def test_average_items_per_merchant
		assert_equal 1.33, sa.average_items_per_merchant
	end

	def test_standard_deviation
		assert_equal 0.58, sa.average_items_per_merchant_standard_deviation
	end

	def test_highest_sellers
		skip
		assert_equal 12, sa.merchants_with_high_item_count.first.name
		assert_equal 12, sa.merchants_with_high_item_count.first.items.count
		assert_equal 12, sa.merchants_with_high_item_count.last.name
		assert_equal 12, sa.merchants_with_high_item_count.last.items.count
	end
end