require './lib/sales_engine'

class SalesAnalyst
  attr_reader :merchants,
              :items

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    @items.all.length.fdiv(@merchants.all.length).round(2)
  end

  # Calebs magic method
  def average_items_per_merchant_standard_deviation
    average_wares = average_items_per_merchant
    merchant_ids = @merchants.all.map do |merchant|
      merchant.id
    end
    items_per_merchant = merchant_ids.map do |id|
      @items.find_all_by_merchant_id(id).length
    end
    sum_of_squares = items_per_merchant.map do |wares|
      (wares - average_wares) ** 2
    end.sum
    (sum_of_squares.fdiv(merchant_ids.length - 1) ** 0.5).round(2)
  end
end
