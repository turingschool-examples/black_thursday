require_relative "./sales_engine"
require_relative "./item_repository"
require_relative "./merchant_repository"
require "bigdecimal"
require "bigdecimal/util"
require "date"

class SalesAnalyst
	attr_reader :items, :merchants, :invoices
	def initialize(items, merchants, invoices)
		@items = items
		@merchants = merchants
		@invoices = invoices
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

	def average_invoices_per_merchant
		(@invoices.all.size / @merchants.all.size.to_f).round(2)
	end

	def average_invoices_per_merchant_standard_deviation
		set = invoices_by_merchant.values
		avg = average_invoices_per_merchant
		standard_deviation(set, avg)
	end

	def invoices_by_merchant
		invoices_per_merchant = Hash.new(0)
		merchant_ids = invoices.all.map {|invoice| invoice.merchant_id}
		merchant_ids.each do |id|
			invoices_per_merchant[id] += 1
		end
		return invoices_per_merchant
	end

	def merchant_z_score(invoice_count)
		mean = average_invoices_per_merchant
		std_dev = average_invoices_per_merchant_standard_deviation
		z_score = (invoice_count - mean) / std_dev
		return z_score.round(2)
	end

	def merchants_by_zscore
		merchant_by_z_score = Hash.new
		invoices_by_merchant.each do |merchant, invoice_count|
			merchant_by_z_score[merchant] = merchant_z_score(invoice_count)
		end
		return merchant_by_z_score
	end

	def top_merchants_by_invoice_count
		top_merchants = []
		merchants_by_zscore.each do |merchants, zscore|
		top_merchants	<< merchants if zscore > 2
		end
		return top_merchants
	end

	def bottom_merchants_by_invoice_count
		bottom_merchants = []
		merchants_by_zscore.each do |merchants, zscore|
		bottom_merchants	<< merchants if zscore < 2
		end
		return bottom_merchants
	end

	def top_days_by_invoice_count
		top_days = []
		weekday_by_zscore.each do |day, zscore|
		top_days	<< day if zscore > 1
		end
		return top_days
	end

	def date_to_day(date)
		weekday = Date.parse(date)
		weekday_num = weekday.wday
		weekday_name = Date::DAYNAMES[weekday_num]
		return weekday_name
	end

	def invoices_by_day
		invoices_per_day = Hash.new(0)
		invoice_dates = invoices.all.map {|invoice| invoice.created_at}
		invoice_dates.each do |date|
			invoices_per_day[date_to_day(date)] += 1
		end
		return invoices_per_day
	end

	def average_invoices_per_day
	 invoices_by_day.values.sum / invoices_by_day.count
	end

	def average_invoices_per_day_standard_deviation
		set = invoices_by_day.values
		avg = average_invoices_per_day
		standard_deviation(set, avg)
	end

	def weekday_by_zscore
		day_by_z_score = Hash.new
		invoices_by_day.each do |day, invoice_count|
			day_by_z_score[day] = weekday_z_score(invoice_count)
		end
		return day_by_z_score
	end

	def weekday_z_score(invoice_count)
		mean = average_invoices_per_day
		std_dev = average_invoices_per_day_standard_deviation
		z_score = (invoice_count - mean) / std_dev
		return z_score.round(2)
	end

	def invoice_status(status)
		status_percentage = ((invoice_by_status_count[(status)].to_f / invoice_by_status_count.values.sum.to_f)*100)
		return status_percentage.round(2)
	end

	def invoice_by_status
		invoices_per_status = Hash.new
		invoices.all.each do |invoice|
			invoices_per_status[invoice.id] = invoice.status
		end
		return invoices_per_status
	end

	def invoice_by_status_count
		status_count = Hash.new(0)
		invoice_by_status.each do |id, status|
			status_count[status.to_sym] += 1
		end
		return status_count
	end


end
