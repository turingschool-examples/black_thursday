require_relative 'statistics'
require_relative 'sales_engine'
require_relative 'date_accessor'

class ItemsCountAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def all_merchants
    engine.merchants.all
  end

  def all_items
    engine.items.all
  end

  def average_items_per_merchant
    find_average(merchant_item_count).round(2)
  end

  def merchant_item_count
    engine.merchants.merchant_item_count
  end

  def average_items_per_merchant_standard_deviation
    stdev(merchant_item_count).round(2)
  end

  def merchants_with_high_item_count
    threshold = stdev(merchant_item_count) + find_average(merchant_item_count)
    all_merchants.find_all { |m| m.items.count > threshold }
  end

  def merchants_with_only_one_item
    all_merchants.find_all {|m| m.items.count == 1}
  end

  def merchants_with_only_one_item_registered_in_month(desired_month)
    registered_then = engine.merchants.all.find_all  do |m|
      m.created_at.month == DateAccessor.months[desired_month.capitalize]
    end
    registered_then.find_all { |m| m.items.count == 1 }
  end

end