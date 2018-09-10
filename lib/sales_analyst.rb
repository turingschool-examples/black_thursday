class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_per_merchant
    (@sales_engine.items.items.count.to_f / @sales_engine.merchants.merchants.count).round(2)
  end

  def average_items_per_merchants_standard_deviation
    items_per_merchant_array
  end

  def items_per_merchant_array
    array = merchant_id_array.inject(Hash.new(0)) do |total, id|
              total[id] += 1
              total
            end
            array.values
            require "pry"; binding.pry

  end

  def merchant_id_array
    merchant_ids = @sales_engine.items.items.map do |item|
                        item.merchant_id
                      end
  end
end
