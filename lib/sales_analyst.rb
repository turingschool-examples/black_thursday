require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
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
      merchant = @merchants.id_repo[id]
      if merchant.items.count > average + standard_dev
        merchant_results << merchant
      end
    end
    merchant_results
  end

  # def average_item_price_for_merchant(merchant_id)
  #   if @merchants.id_repo.include?(merchant_id)
  #     merchant = @merchants.id_repo[merchant_id]

end
