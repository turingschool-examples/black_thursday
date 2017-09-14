require_relative "sales_engine"

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    item_array = se.items.all
    merchant_ids = item_array.map do |item|
                     item.merchant_id
                   end
    item_counts = Hash.new 0
    merchant_ids.each do |merchant_id|
      item_counts[merchant_id] += 1.0
    end
    total_items = item_counts.values.sum
    total_merchants = item_counts.length
    total_items/total_merchants
  end

  # standard dev
  # Take the difference between each number and the mean and square it
  # Sum these square differences together
  # Divide the sum by the number of elements minus 1
  # Take the square root of this result
  # Or, in pseudocode:
  #
  # set = [3,4,5]
  #
  # std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )

end
