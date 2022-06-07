require_relative 'helper'
require 'pry'

class SalesAnalyst
  include Findable
  include Existable

  attr_accessor :item_repository,
                :merchant_repository,
                :invoice_repository,
                :invoice_item_repository,
                :transaction_repository,
                :customer_repository

  def initialize(item_repository, merchant_repository,invoice_repository,invoice_item_repository,transaction_repository,customer_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
    @invoice_item_repository = invoice_item_repository
    @transaction_repository = transaction_repository
    @customer_repository = customer_repository
  end

  def average_items_per_merchant #2.88
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation #3.26
    counts = []
    @merchant_repository.all.each do |merchant|
      counts <<  @item_repository.find_all_by_merchant_id(merchant.id).count
    end
    total = counts.sum {|difference| (difference - average_items_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant > average_items_per_merchant_standard_deviation)
        #avg items per merchant
        merch_array << merchant
      end
    end
    merch_array
  end

  def average_item_price_for_merchant(merch_id)
    price_sum_helper(merch_id) / @item_repository.find_all_by_merchant_id(merch_id).count
  end

  def price_sum_helper(merch_id) #31500
    holder_array = @item_repository.find_all_by_merchant_id(merch_id)
    total_sum = holder_array.sum{|item| item.unit_price_to_dollars}
    total_sum
  end

  def average_average_price_per_merchant
    total_sum = 0
    @merchant_repository.all.each do |merchant|
      total_sum += average_item_price_for_merchant(merchant.id)
    end
    (total_sum / @merchant_repository.all.count).round(2)
  end

  def average_item_price
    total_sum = @item_repository.all.sum {|item| item.unit_price_to_dollars}
    (total_sum / @item_repository.all.count).round(2)
  end

  def item_price_standard_deviation
    total = @item_repository.all.sum {|item| (item.unit_price_to_dollars - average_item_price) ** 2}
     Math.sqrt(total / @item_repository.all.count - 1).round(2)
  end

  def golden_items
    standard_dev = item_price_standard_deviation
    @item_repository.all.select {|item| item.unit_price_to_dollars > (average_item_price + (standard_dev * 2))}
  end
  # => first portion in case we want to split in half

  def invoice_paid_in_full?(invoice_id)
    transactions = @transaction_repository.find_all_by_invoice_id(invoice_id)

    if transactions.length == 0
      return false
    end

    results = transactions.map {|transaction| transaction.result}

    !results.include?("failed")
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id) == false
      return false
    end

    invoice_items = @invoice_item_repository.find_all_by_invoice_id(invoice_id)

    invoice_items.sum {|invoice| invoice.quantity * invoice.unit_price_to_dollars}
  end

  def average_invoices_per_merchant
    (@invoice_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def number_of_invoices_by_merchant_id(merchantid)
    @invoice_repository.all.count {|invoice| invoice.merchant_id == merchantid}
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = @merchant_repository.all.sum {|merchant| (number_of_invoices_by_merchant_id(merchant.id) - mean) ** 2}
    variance = sum / (@merchant_repository.all.count - 1).to_f
    Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    top_merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count > average_items_per_merchant_standard_deviation * 2)
        top_merch_array << merchant
      end
    end
    top_merch_array
  end

  def bottom_merchants_by_invoice_count
    bot_merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count < average_items_per_merchant_standard_deviation * 2)
        bot_merch_array << merchant
      end
    end
    bot_merch_array
  end

  # will likely want to break below into a TimeAnalyst class or something for organizing purposes

  def invoice_day_of_week_by_id(invoice_id)
    created_at_array = (@invoice_repository.find_by_id(invoice_id).created_at).split("-")
    date = Date.new(created_at_array[0].to_i,created_at_array[1].to_i,created_at_array[2].to_i)
    date.wday
  end

  def invoices_by_day_of_week(day)
    numeric_weekday = Date.parse(day).wday
    @invoice_repository.all.count {|invoice| invoice_day_of_week_by_id(invoice.id) == numeric_weekday}
  end

  def average_invoices_by_day_of_week
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    ((weekdays_array.sum {|day| invoices_by_day_of_week(day)}).to_f / 7).round(2)
  end

  def average_invoices_by_day_of_week_standard_deviation
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    mean = average_invoices_by_day_of_week
    sum = weekdays_array.sum {|day| (invoices_by_day_of_week(day) - mean) ** 2}
    variance = sum / 6
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def top_days_by_invoice_count
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    std_dev = average_invoices_by_day_of_week_standard_deviation
    mean = average_invoices_by_day_of_week
    weekdays_array.select {|day| invoices_by_day_of_week(day) - mean > std_dev}
  end

  def invoice_status(status)
    numerator_count = @invoice_repository.find_all_by_status(status).count
    ((numerator_count.to_f / @invoice_repository.all.count.to_f) * 100).round(2)
  end

  def invoices_by_date(date)
    @invoice_repository.find_all_by_transaction_date(date)
  end

  def total_revenue_by_date(date)
    invoices = invoices_by_date(date)
    invoices.sum {|invoice| invoice_total(invoice.id)}
  end

  def total_revenue_by_merchant(merchant_id)
    invoices = @invoice_repository.find_all_by_merchant_id(merchant_id)
    total = 0
    invoices.each do |invoice|
      if invoice_paid_in_full?(invoice.id)
        total += invoice_total(invoice.id)
      end
    end
    total.round(2)
  end

  def top_revenue_earners(number_to_rank = 20)
    @merchant_repository.all.max_by(number_to_rank) {|merchant| total_revenue_by_merchant(merchant.id)}
  end #work in progress

  def most_sold_item_for_merchant(merchant_id)
    #item(s) that have sold the highest quanitity
    # invoice_holder = @invoice_repository.find_all_by_merchant_id(merchant_id)
    # most_sold = []
    # invoice_holder.each do |invoice|
    #   if most_sold.count == 0 #if its the first input into the array, set top price
    #     most_sold << invoice
    #   else #if it is not the first input, compare if greater than or equal to
    #     if item.unit_price > most_sold[0]
    #       most_sold[0] = item #set as top sold
    #     elsif item.unit_price == most_sold[0]
    #       most_sold << item  #push in as array
    #     end
    #   end
    #   most_sold
    # end
  end #in progress -sm

  def best_item_for_merchant(merchant_id)
    #item that has made the most revenue
    item_holder = @item_repository.find_by_id(merchant_id)
    item_most_profitable = []
    item_holder.each do |item|
      if item_most_profitable.count == 0 #if its the first input into the array, set top price
        item_most_profitable << item
      else #if it is not the first input, compare if greater than or equal to
        if item.unit_price > item_most_profitable[0]
          item_most_profitable[0] = item #set as top sold
        elsif item.unit_price == item_most_profitable[0]
          item_most_profitable << item  #push in as array
        end
      end
      item_most_profitable
    end
  end #in progress -sm, might need to return a single item and note possible array

end
