require_relative '../lib/merchant_repository'

class SalesAnalyst
  attr_reader :merchant_repo,
              :item_repo

  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
  end

  def average_items_per_merchant
    average = @item_repo.items.count / @merchant_repo.merchants.count.to_f
    average.round(2)
  end

  def items_per_merchant
    @item_repo.items.each_with_object(Hash.new(0)) do |item, counts|
      counts[item.merchant_id] += 1
    end
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = []
    items_per_merchant.each do |key, value|
      items_per_merchant_array << value
    end

    sum = items_per_merchant_array.inject(0) do |sum, number|
      sum + ((number - average_items_per_merchant) ** 2)
    end

    divided = (sum / items_per_merchant_array.count)
    Math.sqrt(divided).round(2)
  end

  def merchants_with_high_item_count
    one_stddev_up = (average_items_per_merchant + average_items_per_merchant_standard_deviation)

    merchant_ids = items_per_merchant.find_all do |merchant_id, item_count|
      item_count > one_stddev_up
    end

    merchant_ids.map do |merchant_id, item_count|
      @merchant_repo.find_by_id(merchant_id.to_i)
    end
  end

end
