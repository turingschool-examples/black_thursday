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

  def merchants_with_high_item_count
    highest_count = items_per_merchant_hash.find_all do |merchant|
      merchant[1] > (average_item_per_merchant + average_items_per_merchants_standard_deviation)
    end
    highest_count.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    summed_unit_price = items.inject(0) do |sum,item|
                          sum + item.unit_price
                        end
    summed_unit_price/items.count
  end

  def average_average_price_per_merchant
    average_of_all_merchants = items_per_merchant_hash.map do |merchant|
      average_item_price_for_merchant(merchant[0])
    end
      summed = average_of_all_merchants.inject(0) do |sum, num|
                sum + num
              end

      (summed / @sales_engine.merchants.merchants.count).round(2)
  end

  def average_item_cost
    array_of_unit_price = @sales_engine.items.items.map do |item|
                           item.unit_price
                        end

        sum_of_unit_price = array_of_unit_price.inject(0) do |sum, num|
                              sum + num
                            end
        (sum_of_unit_price / @sales_engine.items.items.count).round(2)
  end

end
