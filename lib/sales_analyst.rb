require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  def initialize(items, merchants, invoices)
    @item_repo = items
    @merchant_repo = merchants
    @invoice_repo = invoices
  end

  def num_items_for_each_merchant
    items_per_merchant = {}
    @merchant_repo.all.each do |merchant|
      items_per_merchant[merchant] =
          @item_repo.find_all_by_merchant_id(merchant.id).size
    end
    items_per_merchant
  end

  def count_of_merchants
    @merchant_repo.all.size
  end

  def average_items_per_merchant
    items = num_items_for_each_merchant.values
    (sum(items).to_f / count_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = num_items_for_each_merchant.values
    std_dev(items_per_merchant)
  end

  def average_item_price_for_merchant(id)
    item_list = @item_repo.find_all_by_merchant_id(id)
    item_prices = item_list.map do |item|
      item.unit_price
    end
    mean(item_prices).round(2).to_d
  end

  def merchants_with_high_item_count
    one_std_dev = average_items_per_merchant +
                  average_items_per_merchant_standard_deviation
    high_item_counts = []
    num_items_for_each_merchant.each do |merchant, item_count|
      high_item_counts << merchant if item_count > one_std_dev
    end
    high_item_counts
  end

  def average_average_price_per_merchant
    prices = @merchant_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean(prices)
  end

  def golden_items
    all_item_prices = @item_repo.all.map do |item|
      item.unit_price
    end
    average_item_price = mean(all_item_prices)
    price_std_dev = std_dev(all_item_prices)
    two_std_dev_above_average = average_item_price + (price_std_dev * 2)

    golden_items = []
    @item_repo.all.each do |item|
      golden_items << item if item.unit_price > two_std_dev_above_average
    end
    golden_items
  end

  def num_invoices_per_merchant
    invoices_per_merchant = {}
    @merchant_repo.all.each do |merchant|
      invoices_per_merchant[merchant] =
          @invoice_repo.find_all_by_merchant_id(merchant.id).size
    end
    invoices_per_merchant
  end

  def average_invoices_per_merchant
    merchant_invoices = num_invoices_per_merchant
    count = merchant_invoices.values
    (sum(count).to_f / count.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_count = num_invoices_per_merchant.values
    std_dev(invoice_count)
  end

  def top_merchants_by_invoice_count
    two_deviations_above = average_invoices_per_merchant +
              (average_invoices_per_merchant_standard_deviation * 2)
    top_merchants = []
    num_invoices_per_merchant.each do |merchant, num|
      top_merchants << merchant if num > two_deviations_above
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    two_deviations_below = average_invoices_per_merchant -
              (average_invoices_per_merchant_standard_deviation * 2)
    top_merchants = []
    num_invoices_per_merchant.each do |merchant, num|
      top_merchants << merchant if num < two_deviations_below
    end
    top_merchants
  end

  def top_days_by_invoice_count
    week = {"Sunday" => 0,
            "Monday" => 0,
            "Tuesday" => 0,
            "Wednesday" => 0,
            "Thursday" => 0,
            "Friday" => 0,
            "Saturday" => 0}

    days = @invoice_repo.all.map do |invoice|
            invoice.created_at.wday
    end
    days.each do |day_num|
      if day_num == 0
        week["Sunday"] += 1
      elsif day_num == 1
        week["Monday"] += 1
      elsif day_num == 2
        week["Tuesday"] += 1
      elsif day_num == 3
        week["Wednesday"] += 1
      elsif day_num == 4
        week["Thursday"] += 1
      elsif day_num == 5
        week["Friday"] += 1
      elsif day_num == 6
        week["Saturday"] += 1
      else
      end
    end
    average_of_week = (sum(week.values) / 7).round(2)
    deviation_of_week = (average_of_week + (std_dev(week.values))).round(2)
    top_days = []
    week.each do |day, num|
      if num > deviation_of_week
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)

  end
  # maths

  def sum(nums)
    nums.inject(0) do |running_count, item|
      running_count + item
    end
  end

  def mean(nums)
    sum = sum(nums)
    (sum.to_f / nums.length).round(2).to_d
  end

  def std_dev(nums)
    mean = mean(nums)
    nums = nums.map do |num|
      (num - mean) * (num - mean)
    end
    nums_sum = sum(nums)
    variance = nums_sum.to_f / (nums.length - 1)
    Math.sqrt(variance).round(2)
  end
end
