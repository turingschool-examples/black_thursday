require_relative '../lib/standard_deviation'
class MerchantAnalyst

  include StandardDeviation

  def initialize(all_merchants)
    @all_merchants = all_merchants
  end

  def active_merchants
    @all_merchants.find_all do |merchant|
      average_item_price_for_merchant(merchant.id) != nil
    end
  end

  def find_merchant(id_to_find)
    @all_merchants.find do |merchant|
      merchant.id == id_to_find
    end
  end

  def average_items_per_merchant
    mean(items_per_merchant).round(2)
  end

  def items_per_merchant
    @all_merchants.map do |merchant|
      merchant.items.count
    end
  end
  
  def item_prices_per_merchant
    active_merchants.map do |merchant|
      merchant.items.reduce(0) do |total, item|
        total += item.unit_price
        total
      end
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    @all_merchants.find_all do |merchant|
      merchant.items.count > (avg + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    return nil if merchant == nil || merchant.items == []

    (total_item_price_for_merchant(merchant) /
    merchant.items.length).
    round(2)
  end

  def total_item_price_for_merchant(merchant)
    merchant.items.reduce(0) do |total, item|
      total += item.unit_price
      total
    end
  end

  def average_average_price_per_merchant
    return nil if @all_merchants == [] || active_merchants == []

    (total_item_price_for_active_merchants /
    active_merchants.length).
    floor(2)
  end

  def total_item_price_for_active_merchants
    active_merchants.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
      total
    end
  end

end
