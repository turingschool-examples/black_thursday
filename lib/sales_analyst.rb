require './lib/sales_engine'
class SalesAnalyst
  attr_reader :item_repository

  def initialize(item_repository, merchant_repository)
    #delete merchant_repository from this and sales engine if we end up not using 
    @item_repository = item_repository
  end

  def merchant_items_hash
    items_hash = @item_repository.all.group_by {|item| item.merchant_id}
    items_hash.map {|keys, values| items_hash[keys] = values.count}
    items_hash
  end

  def average_items_per_merchant
    number_of_merchants = merchant_items_hash.keys.count
    total_number_of_items = merchant_items_hash.values.sum
    average = (total_number_of_items.to_f / number_of_merchants)
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    diff_squared = merchant_items_hash.values.map {|item_count| (item_count-average_items_per_merchant)**2}
    std_dev = (diff_squared.sum / (diff_squared.count.to_f - 1))**0.5
    std_dev.round(2)
  end
end
