require 'bigdecimal'

# Analyzer module
class Analyzer

  def initialize(sales_engine)
    @engine = sales_engine
    @merchant_repo = @engine.merchants
    @item_repo = @engine.items
    @invoice_repo = @engine.invoices
  end

  def average(sum, total_elements)
    (BigDecimal(sum) / BigDecimal(total_elements)).round(2)
  end

  def standard_deviation(set, mean)
    mean_difference_squared = set.inject(0) do |sum, number_in_set|
      sum + ((number_in_set - mean)**2)
    end
    Math.sqrt(mean_difference_squared / (set.count - 1)).round(2)
  end

  def number_of_merchants
    @merchant_repo.all.count
  end

  def number_of_items
    @item_repo.all.count
  end

  def number_of_invoices
    @invoice_repo.all.count
  end

  def items_per_merchant
    @item_repo.all.group_by(&:merchant_id)
  end

  def number_of_items_per_merchant
    number_of_items_per_merchant = items_per_merchant
    number_of_items_per_merchant.each do |id, items|
      number_of_items_per_merchant[id] = items.length
    end
    number_of_items_per_merchant
  end

  def average_item_price
    total_items = @item_repo.all.count
    all_item_prices = @item_repo.all.map(&:unit_price)
    average(all_item_prices.inject(:+), total_items)
  end

  def invoice_count(merchant_id)
    @invoice_repo.find_all_by_merchant_id(merchant_id).count
  end

  def invoice_count_by_created_date(created_date)
    @invoice_repo.find_all_by_created_date(created_date).count
  end

  def invoices_per_merchant
    @invoice_repo.all.group_by(&:merchant_id)
  end

  def number_of_invoices_per_merchant
    number_of_invoices_per_merchant = invoices_per_merchant
    number_of_invoices_per_merchant.each do |id, invoices|
      number_of_invoices_per_merchant[id] = invoices.length
    end
    number_of_invoices_per_merchant
  end

  def merchants_per_count
    merchants_per_count = {}
    number_of_invoices_per_merchant.each do |id, count|
      if merchants_per_count[count]
        merchants_per_count[count] << id
      else
        merchants_per_count[count] = [] << id
      end
    end
    merchants_per_count
  end

  def sum_of_item_price_for_merchant(merchant_id)
    items_per_merchant[merchant_id].inject(0) do |sum, item|
      sum + item.unit_price
    end
  end

  def average_items_per_merchant_plus_one_standard_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def all_invoice_created_dates
    @invoice_repo.all.map(&:created_at)
  end

  def average_invoices_per_merchant_plus_two_standard_deviations
    (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation*2)).round(2)
  end

  def average_invoices_per_merchant_minus_two_standard_deviations
    (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation*2)).round(2)
  end

  def number_of_invoices_per_weekday
    number_of_invoices_by_weekday.values
  end

  def average_invoices_per_weekday
    average_invoices_per_weekday = average(number_of_invoices_per_weekday.inject(:+),
                                           number_of_invoices_per_weekday.count)
  end

  def number_of_invoices_by_weekday
    weekdays = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
    all_days = @invoice_repo.all.map(&:created_at)
    by_dates = all_days.group_by do |date|
      weekdays[date.wday]
    end
    by_dates.each_key do |id|
      by_dates[id] = by_dates[id].count
    end
  end

  def average_invoices_per_weekday_standard_deviation
    standard_deviation(number_of_invoices_per_weekday, average_invoices_per_weekday)
  end

  def average_invoices_per_weekday_plus_one_standard_deviation
    average_invoices_per_weekday + average_invoices_per_weekday_standard_deviation
  end

  def number_of_invoices_by_status(status_to_find)
    @invoice_repo.all.map(&:status).find_all do |invoice_status|
      invoice_status == status_to_find
    end
  end

  def invoice_status(status_to_check)
    total = number_of_invoices.to_f
    total_at_status = number_of_invoices_by_status(status_to_check).length.to_f
    ((total_at_status / total)*100).round(2)
  end
end
