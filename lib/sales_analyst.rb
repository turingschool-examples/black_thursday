require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine, :items, :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items.all
    @merchants = sales_engine.merchants.all
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    total_difference = merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      #   Take the difference between each number and the mean, then square it.
      sum += (merchant_items.count - avg)**2
      #   ^Sum these square differences together.
    end
    Math.sqrt(total_difference / (merchants.length - 1)).round(2)
    # Divide the sum by the number of elements minus 1.
    # Take the square root of this result.
  end

  def merchants_with_high_item_count
    # merchants with 5 or more items
    double = average_items_per_merchant_standard_deviation * 2
    merchants.find_all do |merchant|
      # KR refactor opportunity, 33 same as line 19
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > double
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      BigDecimal(0)
    else
      price = BigDecimal(items.inject(0) do |sum, item|
                           sum + BigDecimal(item.unit_price)
                         end) # average item price)
      price / items.count
    end
  end

  def average_average_price_per_merchant
    total_price = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.inject(0, :+)
    total_price / merchants.count
  end

  def golden_items
    # avg items per merchant
    # avg items per merchant std dev

    # avg item price
    test = items.sum do |item|
      BigDecimal(item.unit_price)
    end
    avg_item_price = test / items.count

    # avg item price std deviation
    total_difference = items.inject(0) do |sum, item|
        # require 'pry'; binding.pry
    #   merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      #   Take the difference between each number and the mean, then square it.
      sum += (item.unit_price.to_f - avg_item_price)**2
      #   ^Sum these square differences together.
    end
    std_dev = Math.sqrt(total_difference / (test - 1)).round(2)

    # items w/ price > std dev * 3
    items.find_all do |item|
      item.unit_price.to_f > (std_dev * 3)
    end
  end

  def golden_items_std_dev
   
  end
end
