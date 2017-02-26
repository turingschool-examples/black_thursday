require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test 
	attr_reader :se, :sa, :mr, :ir, :se_one, :sa_one

	def setup
		@se = SalesEngine.from_csv({
  	:items     => "./test/fixtures/item_fixtures.csv",
  	:merchants => "./test/fixtures/merchant_fixtures.csv",
  	:invoices => "./test/fixtures/invoices_fixture.csv"
		})
		@mr = se.merchants
		@ir = se.items
		@sa = SalesAnalyst.new(se)
	end

	def test_there_is_a_sales_analyst
		assert_instance_of SalesAnalyst, sa
	end

	def test_that_calculates_avg_items_per_merchant
		assert_equal 1.69, sa.average_items_per_merchant
	end

	def test_it_calculates_diff_btw_mean_and_count_sqrd_summed
		assert_equal 26.6693, sa.diff_btw_mean_and_item_c_sqrd_summed
	end

	def test_avg_items_per_merchant_std_deviation
		assert_equal 1.49, sa.average_items_per_merchant_standard_deviation
	end

	def test_high_item_count_in_merchant
		high_item = sa.merchants_with_high_item_count
		assert_equal 1, high_item.count
		assert_equal Merchant, high_item.first.class
		assert_equal 'BowlsByChris', high_item.first.name
		assert_equal 12334145, high_item.first.id
		refute high_item.empty?
	end

	def test_get_whole_merchant_items_set
		assert_equal 13, sa.get_merchant_items_set.count
		assert_equal Array, sa.get_merchant_items_set.class
	end

	def test_avg_item_price_for_a_merchant
		assert_equal BigDecimal, sa.average_item_price_for_merchant(12334145).class
	end

	def test_aggregate_avg_for_avg_price_per_merchant
		skip
		se_1 = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
		sa_2 = SalesAnalyst.new(se_1)

		assert_equal BigDecimal, sa_2.average_average_price_per_merchant.class
	end

	def test_average_item_price_across_merchants
		assert_equal BigDecimal, sa.average_item_price.class
	end

	def test_item_price_set
		assert_equal Array, sa.get_item_price_set.class
		assert_equal 22, sa.get_item_price_set.count
	end

	def test_diff_mean_and_item_price_sqrd_summed
		assert_equal BigDecimal, sa.difference_between_mean_and_item_price_squared_summed.class
	end

	def test_standard_deviation_avg_items
		assert_equal 188.05, sa.average_item_price_standard_deviation
	end

	def test_golden_items
		name_1 = "New Orleans Mardi Gras 2016 4&#39; by 2&#39; acrylic paintings by local artist"
		assert_equal name_1, sa.golden_items.first.name
		assert_equal 263556752, sa.golden_items.first.id
		assert_equal Array, sa.golden_items.class
	end

	def test_average_invoices_per_merchant
		assert_equal 5.15, sa.average_invoices_per_merchant
	end

	def test_it_can_get_whole_invoice_set
		skip #this passes, slows down
		se_one = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
    })
    sa_one = SalesAnalyst.new(se_one)
		assert_equal Array, sa_one.get_merchant_invoices_set.class
		assert_equal 475, sa_one.get_merchant_invoices_set.count
		assert_equal 7, sa_one.get_merchant_invoices_set.last
	end

	def test_difference_between_the_mean_and_invoice_count_sqrd_summed
		assert_equal 335.49, sa.difference_between_mean_and_invoice_count_squared_summed
	end

	def test_average_invoices_per_merchant_std_deviation
		assert_equal 5.29, sa.average_invoices_per_merchant_standard_deviation
	end
end