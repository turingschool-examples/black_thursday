require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def find_all(category)
    @sales_engine.category.all
  end

  def average_items_per_merchant
    item_merchant_ids = @sales_engine.items.all.map do |item|
      item.merchant_id
    end

    merchant_item_matches = @sales_engine.merchants.all.map do |merchant|
      item_merchant_ids.map do |item_id|
        merchant.id == item_id
      end
    end

    count = merchant_item_matches.map do |array|
      array.count(true)
    end
    average_items = count.sum.to_f / @sales_engine.merchants.all.count
    average_items.round(2)
  end
end
