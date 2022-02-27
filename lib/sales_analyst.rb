require_relative 'sales_engine'
require_relative 'item_repository'

class SalesAnalyst
  attr_reader

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
    @items_per_merchant = {}
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def total_items_per_merchant
    @items_per_merchant = {}
    @items.each do |item|
      @items_per_merchant[item.merchant_id] = 0 unless @items_per_merchant.has_key?(item.merchant_id)
      !@items_per_merchant[item.merchant_id] += 1
    end
    @items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    total_items_per_merchant
    total_square_diff = 0
    total_items_per_merchant.values.map do |item_count|
      total_square_diff += ((item_count - average_items_per_merchant)**2)
    end
    Math.sqrt(total_square_diff / (@merchants.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    @high_item_merchants = []
    total_items_per_merchant.select { |_k, v| v > 6 }.keys.each do |high_id|
      @merchants.each do |merchant|
        @high_item_merchants << merchant if merchant.id == high_id
      end
    end
    @high_item_merchants
  end

  def merchant_id_array
    @items.map do |item|
      item.merchant_id
    end
  end

  def items_per_merchant_list
    merchant_id_array.each_with_object(Hash.new(0)) do |merchant_id, total|
      total[merchant_id] += 1
    end
  end
end
