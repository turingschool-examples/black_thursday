require './lib/sales_engine'
class SalesAnalyst
  attr_reader :item_repository

  def initialize(item_repository, merchant_repository)
    @item_repository = item_repository
    # @merchant_repository = merchant_repository
  end

  def average_items_per_merchant
    items_hash = @item_repository.all.group_by {|item| item.merchant_id}
    items_hash.map {|keys, values| items_hash[keys] = values.count}
    number_of_merchants = items_hash.keys.count
    total_number_of_items = items_hash.values.sum
    average = (total_number_of_items.to_f / number_of_merchants).round(2)
  end
end
