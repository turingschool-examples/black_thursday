require_relative '../lib/sales_engine'

class SalesAnalyst

  attr_reader :sales_engine,
              :avg_items,
              :avg_prices_per_merch

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @avg_items = @sales_engine.merchants.all_merchant_data.map do |merch|
    merch.items.count
    end
    (avg_items.reduce{|sum, num| sum + num}.to_f / avg_items.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = self.average_items_per_merchant
    sum = @avg_items.reduce(0){|sum, num| sum + (num - mean)**2}
    actual = Math.sqrt(sum/(@avg_items.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    @sales_engine.merchants.all_merchant_data.find_all do |merchant|
      merchant.items.count > (self.average_items_per_merchant +
       self.average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merch_items = @sales_engine.item_output(merchant_id)

    item_prices = []
      merch_items.find_all do |item|
          item_prices << item.unit_price.to_i
      end

      if item_prices.count > 0
        avg_merch_item_price = item_prices.reduce(:+) /
        (item_prices.count)
      end

  end

  def average_average_price_per_merchant
    merchants = @sales_engine.merchants.all
    merch_ids = merchants.map do |merchant|
      merchant.id.to_i
    end
    @avg_prices_per_merch = []
    merch_ids.each do |merchant_id|
      if self.average_item_price_for_merchant(merchant_id) != nil
        @avg_prices_per_merch << self.average_item_price_for_merchant(merchant_id)
      end
    end
      avg_prices_per_merch.reduce(:+) / avg_prices_per_merch.count
  end

  def standard_deviation_of_prices
    mean = self.average_average_price_per_merchant
    sum = @avg_prices_per_merch.reduce(0){|sum, num| sum + (num - mean)**2}
    std_dev = Math.sqrt(sum/(@avg_prices_per_merch.count - 1)).round(2)
  end

  def golden_items
    std_dev = self.standard_deviation_of_prices
    @sales_engine.items.all_item_data.find_all do |item|
      item.unit_price.to_i > (std_dev * 2)
    end
  end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
sa = SalesAnalyst.new(se)
puts sa.golden_items
