require 'CSV'
require './lib/sales_engine'

class Analyst

  def initialize(engine)
    @engine = engine
  end

  # def average_items_per_merchant
  #   grouped_hash = @engine.items.group_by_merchant_id.map do |merchant|
  #     merchant[1].count
  # end
  # end

  def items_per_merchant
    @engine.items.group_by_merchant_id
  end

  def total_items_across_all_merchants
    items_per_merchant.values.flatten.count.to_f
  end

  def total_merchants
    items_per_merchant.keys.count
  end

  def average_items_per_merchant
    (total_items_across_all_merchants / total_merchants).round(2)
  end

  def all_items_by_merchant
    items_per_merchant.map do |merchant, items|
      items.count
    end 
  end

end
