require './lib/sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
  end

  def to_cents(int)
    int.to_f / 100
  end

  def average_items_per_merchant
    average = @items.id_repo.count.to_f / @merchants.id_repo.count.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    sum = 0
    @merchants.id_repo.keys.each do |id|
      merchant = @merchants.id_repo[id]
      sum += (merchant.items.count - average) ** 2
    end
    divided_result = sum / (@merchants.id_repo.count - 1)
    standard_dev = Math.sqrt(divided_result).round(2)
  end

  def merchants_with_high_item_count
    merchant_results = []
    average = average_items_per_merchant
    standard_dev = average_items_per_merchant_standard_deviation
    @merchants.id_repo.keys.each do |id|
      merchant = @merchants.find_by_id(id)
      if merchant.items.count > average + standard_dev
        merchant_results << merchant
      end
    end
    merchant_results
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    if !(merchant.nil?)
      items = merchant.items
      total_price = 0
      items.each do |item|
        total_price += item.unit_price.to_i
      end
      average = (to_cents(total_price.to_f / items.count.to_f)).round(2)
    end
  end

  def average_price_per_merchant
    item_price_sum = 0
    @items.price_repo.keys.each do |price|
      @items.find_all_by_price(price).count.times do
        item_price_sum += price.to_i
      end
    end
    average_price = (to_cents(item_price_sum.to_f / @merchants.id_repo.count.to_f)).round(2)
  end
end
