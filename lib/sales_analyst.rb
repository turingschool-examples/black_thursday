require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.all_items.length.fdiv(@sales_engine.all_merchants.length).round(2)
  end

  def number_items_per_merchant
    item_merchant_hash = {}
    @sales_engine.all_merchants.each do |merchant|
      item_merchant_hash[merchant] = @sales_engine.items.find_all_by_merchant_id(merchant.id).length
    end
    item_merchant_hash
  end

  def avg(data)
    data.sum.fdiv(data.count)
  end

  def std_dev(data)
    numerator = data.reduce(0) do |sum, num|
      sum + (num - avg(data))**2
    end
    Math.sqrt(numerator/(data.count - 1)).round(2)
  end
  #why the -1 ???

  def average_items_per_merchant_standard_deviation
    std_dev(self.number_items_per_merchant.values).round(2)
  end

  def merchants_with_high_item_count
    top_merchants = []
    sigma = (average_items_per_merchant_standard_deviation + average_items_per_merchant)
    number_items_per_merchant.find_all do |merchant, quantity|
      if quantity > sigma
        top_merchants << merchant
      end
    end
    top_merchants
  end

  # def golden_items
  #   top_items = []
  #   sigma2 = ((average_items_per_merchant_standard_deviation * 2) + average_items_per_merchant)
  #   number_items_per_merchant.find_all do |merchant, quantity|
  #     if quantity > sigma
  #       top_merchants << merchant
  #     end
  #   end
  #   top_items
  # end
end
