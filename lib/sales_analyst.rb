class SalesAnalyst
  attr_reader :engine
  def initialize(engine = nil)
    @engine = engine
  end
  def average_items_per_merchant
    (item_amount.sum / item_amount.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(divide_diff_and_square_sum).round(2)
  end

  def item_amount
    @engine.merchants.all.map do |merchant|
      @engine.find_all_by_merchant_id(merchant.id).length
    end
  end

  def diff_and_square
    item_amount.map do |amount|
      (amount - average_items_per_merchant)**2
    end
  end

  def diff_and_square_sum
    diff_and_square.sum
  end

  def divide_diff_and_square_sum
    diff_and_square_sum / (item_amount.length - 1)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    #require 'pry' ;binding.pry
    @engine.merchants.all.find_all do |merchant|
      merchant.items.length >
      (average_items_per_merchant + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    prices = @engine.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
    (prices.sum / prices.length).round(2)
  end

  def average_average_price_per_merchant
    averages = @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.sum / averages.length).round(2)
  end
end
