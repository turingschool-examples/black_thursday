require_relative 'items_repo'
require_relative 'merchant_repo'

class SalesAnalyst

  attr_reader :merchants, :items

  def initialize(sales_engine)
    # binding.pry
    @merchants     = sales_engine.merchants
    @items         = sales_engine.items
  end

  def self.from_csv(sales_engine)
    new(sales_engine)
  end

  def average_items_per_merchant
    return @average_items if defined? @average_items
    average = @items.all_items.count.to_f
    average_1 = @merchants.all_merchants.count.to_f
    complete_average = average / average_1
    @average_items = complete_average.round(2)
    @average_items
  end

  def average_items_per_merchant_standard_deviation
    @merchant_deviations = @merchants.all_merchants.map do |merchant|
      (merchant.items.count - average_items_per_merchant)**2
    end
    Math.sqrt(@merchant_deviations.inject(0,:+) / @merchants.all_merchants.count).round(2)
  end

  def merchants_with_high_item_count
    standard_deviation = 3.26
    @merchant_deviations = @merchants.all_merchants.map do |merchant|
      m

    end
  end
end
