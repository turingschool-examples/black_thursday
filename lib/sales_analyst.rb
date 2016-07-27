require_relative '../sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    return nil if merchant == nil || merchant.items == []

    (total_item_price_for_merchant(merchant) /
    merchant.items.length).
    round(2)
  end

  def find_merchant(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id)
  end

  def total_item_price_for_merchant(merchant)
    merchant.items.map do |item|
      item.unit_price
    end.inject(:+)
  end

  def average_average_item_price_per_merchant
    all_merchants = find_all_merchants
    active_merchants = find_active_merchants(all_merchants)
    return nil if all_merchants == [] || active_merchants == []

    (total_item_price_for_active_merchants(active_merchants) /
    active_merchants.length).
    round(2)
  end

  def find_all_merchants
    sales_engine.merchants.all
  end

  def find_active_merchants(all_merchants)
    all_merchants.find_all do |merchant|
      average_item_price_for_merchant(merchant.id) != nil
    end
  end

  def total_item_price_for_active_merchants(active_merchants)
    active_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.inject(:+)
  end
end
