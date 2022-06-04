require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "bigdecimal"

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

end
