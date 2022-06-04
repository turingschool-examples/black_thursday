require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "bigdecimal"
require "bigdecimal/util"

class SalesAnalyst
	attr_reader :items, :merchants
	def initialize(items, merchants)
		@items = items
		@merchants = merchants
	end

	def average_items_per_merchant
		average_number = items.all.count.to_f / merchants.all.count.to_f
		return average_number.round(2)
	end

	def items_by_merchant
		items_per_merchant = Hash.new(0)
		merchant_ids = items.all.map {|item| item.merchant_id}
		merchant_ids.each do |id|
			items_per_merchant[id] += 1
		end
		return items_per_merchant
	end

	def average_items_per_merchant_standard_deviation
		set = items_by_merchant.values
		mean = average_items_per_merchant
    sums = set.sum { |num| (num - mean)**2 }
    std_dev = Math.sqrt(sums / (set.length - 1).to_f)
    std_dev.round(2)
	end

	def merchants_with_high_item_count
		standard_deviation = average_items_per_merchant_standard_deviation
		mean_and_standard_dev = standard_deviation + average_items_per_merchant
		merchants_with_high_sales = []
		items_by_merchant.each_pair do |merchant, items|
			merchants_with_high_sales << merchant if items > mean_and_standard_dev
		end
		return merchants_with_high_sales
	end

	def average_item_price_for_merchant(merchant_id)
		find_merchant = @items.find_all_by_merchant_id(merchant_id)
		items_sum = find_merchant.sum do |item|
			item.unit_price.to_f
		end
		(items_sum / find_merchant.count).to_d(3)
	end

	def average_average_price_per_merchant
		merchant_price_sums = []
		merchant_ids = items.all.map {|item| item.merchant_id.to_i}
		merchant_ids.each do |id|
			merchant_price_sums	<< average_item_price_for_merchant(id).to_f
		end
		(merchant_price_sums.sum / merchant_price_sums.size).to_d(3)
	end

	def standard_deviation(values, mean)
    sums = values.sum { |value| (value - mean)**2 }
    std_dev = Math.sqrt(sums / (values.length - 1).to_f)
    std_dev.round(2)
  end

	def golden_items
		array_of_all_prices = @items.all.map {|item| item.unit_price.to_i}
		set = array_of_all_prices
		mean = array_of_all_prices.sum / array_of_all_prices.size
		std_dev = standard_deviation(set, mean)
		minimum_golden_price = mean += (2 * std_dev)
		items.all.find_all{ |item| item.unit_price.to_i > minimum_golden_price }
	end

end
