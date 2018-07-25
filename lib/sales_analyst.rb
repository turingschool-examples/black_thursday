require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

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

    stddev_sum = items_per_merchant_array.inject(0) do |sum, number|
      sum + ((number - average_items_per_merchant) ** 2)
    end

    divided = (stddev_sum / items_per_merchant_array.count)
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

  def average_item_price_for_merchant(merchant_id)
    item_list = @item_repo.find_all_by_merchant_id(merchant_id)
    prices = item_list.map do |item|
      item.unit_price
    end
    item_denominator = items_per_merchant[merchant_id.to_s]

    (sum(prices).to_f / item_denominator).round(2).to_d
  end

  def sum(array)
    array.inject(0) do |sum, number|
      sum + number
    end
  end

  def average_average_price_per_merchant
    total_average_price = @merchant_repo.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id.to_i)
    end

    (sum(total_average_price).to_f / @merchant_repo.merchants.count).round(2).to_d
  end

  def golden_items
    total_repo_value = @item_repo.items.inject(0) do |sum, item|
      sum + item.unit_price
    end

    average_price = total_repo_value / @item_repo.items.count

    stddev_sum = @item_repo.items.inject(0) do |sum, item|
        sum + ((item.unit_price - average_price) ** 2)
    end
    # binding.pry

    divided = (stddev_sum / @item_repo.items.count)
    stddev = Math.sqrt(divided).round(2)
    @item_repo.items.find_all do |item|
      item.unit_price > ((stddev * 2) + average_price)
    end


  end
end
