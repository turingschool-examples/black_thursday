class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_per_merchant
    (@sales_engine.items.items.count.to_f / @sales_engine.merchants.merchants.count).round(2)
  end

  def average_items_per_merchants_standard_deviation
    differences_squared = items_per_merchant_hash.values.map do |number|
                            (number - average_item_per_merchant) ** 2
                          end

        summed = differences_squared.inject(0) do |sum, num|
                    sum + num
                  end

    divided_sum = summed / (items_per_merchant_hash.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def items_per_merchant_hash
    merchant_id_array.inject(Hash.new(0)) do |total, id|
              total[id] += 1
              total
            end
  end

  def merchant_id_array
    merchant_ids = @sales_engine.items.items.map do |item|
                        item.merchant_id
                      end
  end

end
