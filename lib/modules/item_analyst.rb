require_relative 'arithmetic'

module ItemAnalyst
  extend Arithmetic

  def self.average_items_per_merchant(merchants)
    average(merchants.map {|merchant| merchant.items.length})
  end

  def self.average_items_per_merchant_standard_deviation(merchants)
    standard_deviation(merchants.map {|merchant| merchant.items.length})
  end

  def self.add_items_and_std_deviation(merchants)
    average_items_per_merchant(merchants) +
    average_items_per_merchant_standard_deviation(merchants)
  end

  def self.merchants_with_high_item_count(merchants)
    count = add_items_and_std_deviation(merchants)
    merchants.select {|merchant| merchant.items.count > count}
  end

  def self.average_item_price_for_merchant(merchant_id, engine)
    items = engine.find_all_by_merchant_id(merchant_id)
    average(items.map(&:unit_price))
  end

  def self.average_average_price_per_merchant(merchants, engine)
    avg = merchants.map {|m|average_item_price_for_merchant(m.id, engine)}
    (avg.sum / avg.length).floor(2)
  end

  def self.golden_items(items)
    count = (avg_item_price(items) + avg_item_price_std_deviation(items) * 2)
    items.select {|item| item.unit_price > count}
  end

  def self.avg_item_price(items)
    average(items.map(&:unit_price))
  end

  def self.avg_item_price_std_deviation(items)
    standard_deviation(items.map(&:unit_price))
  end
end