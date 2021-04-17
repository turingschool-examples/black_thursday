require_relative './sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def num_of_items_per_merchant
    all_items = @sales_engine.items.all
    all_merchants = @sales_engine.merchants.all

    all_merchants.each_with_object({}) do |merchant, total_per_merchant|
      total_items = all_items.count do |item|
        item.merchant_id == merchant.id
      end
      total_per_merchant[merchant] = total_items
    end
  end

  def average_items_per_merchant
    items = @sales_engine.items.all
    merchants = @sales_engine.merchants.all

    items.length / merchants.length
  end
  end
end
