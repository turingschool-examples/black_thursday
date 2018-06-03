require 'pry'

class SalesAnalyst
  # attr_reader :engine

  def initialize(engine)
    @engine = engine
    @items = @engine.items.all
    @merchants = @engine.merchants.all
    @invoices = @engine.invoices.all
  end

  def average_items_per_merchant
    (@items.count/@merchants.count.to_f).round(2)
  end

  def items_grouped_by_merchant_id
    @items.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_by_merchant_id
    items_grouped_by_merchant_id.map do |merchant_id,item_list|
      item_list.count
    end
  end

  def item_count_variance
    mean = average_items_per_merchant
    item_count_by_merchant_id.map do |count|
      (count - mean) ** 2
    end
  end

  def sum_of_variance
    item_count_variance.inject(:+)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(sum_of_variance/(item_count_by_merchant_id.count-1)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    one_std_dev = mean + std_dev
    items_grouped_by_merchant_id.map do |id,item_list|
      @engine.merchants.find_by_id(id) if item_list.count > one_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    prices = items_gropued_by_merchant_id[merchant_id].map do |item|
      item.unit_price
    end
    (prices.inject(:+)/prices.count).round(2)
  end

  def average_average_price_per_merchant
    avg_prices = items_gropued_by_merchant_id.keys.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (avg_prices.inject(:+)/avg_prices.count).round(2)
  end

  def all_item_unit_prices
    @items.map do |item|
      item.unit_price
    end
  end

  def average_item_unit_price
    (all_item_unit_prices.inject(:+)/all_item_unit_prices.count).round(2)
  end

  def price_variance
    mean = average_item_unit_price
    @items.map do |item|
      (item.unit_price - mean) ** 2
    end
  end

  def unit_price_std_dev
    sum = price_variance.inject(:+)
    Math.sqrt(sum/(all_item_unit_prices.count-1)).round(2)
  end

  def golden_items
    std_dev = unit_price_std_dev
    mean = average_item_unit_price
    two_std_dev = mean + (std_dev * 2)
    @items.map do |item|
      item if item.unit_price > two_std_dev
    end.compact
  end

  def average_invoices_per_merchant
    (@invoices.count/@merchants.count.to_f).round(2)
  end

def average_invoices_per_merchant_standard_deviation
  # => 3.29
  # Who are our top performing merchants?
  # Which merchants are more than two standard deviations above the mean?
end

def top_merchants_by_invoice_count
  # => [merchant, merchant, merchant]
  # Who are our lowest performing merchants?
  # Which merchants are more than two standard deviations below the mean?
end

def bottom_merchants_by_invoice_count
  # => [merchant, merchant, merchant]
  # Which days of the week see the most sales?
  # On which days are invoices created at more than one standard deviation above the mean?
end

def top_days_by_invoice_count
  # => ["Sunday", "Saturday"]
  # What percentage of invoices are not shipped?
  # What percentage of invoices are shipped vs pending vs returned? (takes symbol as argument)
end

def invoice_status
  # sales_analyst.invoice_status(:pending) # => 29.55
  # sales_analyst.invoice_status(:shipped) # => 56.95
  # sales_analyst.invoice_status(:returned) # => 13.5
end

def invoice_paid_in_full?(invoice_id)
  # returns true if the Invoice with the corresponding id is paid in full
end

def invoice_total(invoice_id)
  # returns the total $ amount of the Invoice with the corresponding id.
  # Failed charges should never be counted in revenue totals or statistics.
  # An invoice is considered paid in full if it has a successful transaction
end

def top_revenue_earners(x)
  #=> [merchant, merchant, merchant, merchant, merchant]
  # If no number is given for top_revenue_earners, it takes the top 20 merchants by default:
end

def top_revenue_earners
  #=> [merchant * 20]
end

def merchants_with_pending_invoices
  #=> [merchant, merchant, merchant] Note: an invoice is considered pending if none of its transactions are successful.
end

def merchants_with_only_one_item
  #=> [merchant, merchant, merchant] And merchants that only sell one item by the month they registered (merchant.created_at):
end

def merchants_with_only_one_item_registered_in_month("Month name")
  #=> [merchant, merchant, merchant] Find the total revenue for a single merchant:
end

def revenue_by_merchant(merchant_id)
  #=> $, which item sold most in terms of quantity and revenue:
end

def most_sold_item_for_merchant(merchant_id)
  #=> [item] (in terms of quantity sold) or, if there is a tie, [item, item, item]
end

def best_item_for_merchant(merchant_id)
  #=> item (in terms of revenue generated)
end

end
