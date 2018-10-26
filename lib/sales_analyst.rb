require 'bigdecimal'

class SalesAnalyst
  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo.repo_array
    @items = item_repo.repo_array
    @m_repo = merchant_repo
    @i_repo = item_repo
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def merchant_item_list(merchant)
    a = @items.find_all do |item|
      item.merchant_id == merchant.id
    end
  end

  def sum_array(elems)
    sum = 0
    elems.each { |elem| sum += elem }
    sum
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchs_minus_one = @merchants.count - 1
    squared_diffs = @merchants.map do |merchant|
      items = merchant_item_list(merchant).count
      (items - average) ** 2
    end
    (Math.sqrt(sum_array(squared_diffs) / merchs_minus_one)).round(2)
  end

  def merchants_with_high_item_count
    high_items = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count_merchs = []
    @merchants.each do |merch|
      item_count = merchant_item_list(merch).count
      if  item_count > high_items
        high_count_merchs << merch
      end
    end
    high_count_merchs
  end

  def average_item_price_for_merchant(id)
    sum = BigDecimal.new("0")
    merchant = @m_repo.find_by_id(id)
    list = merchant_item_list(merchant)
    list.each { |item| sum += item.unit_price }
    (sum / list.count).round(2)
  end

  def average_average_price_per_merchant
    sum = BigDecimal.new("0")
    @merchants.each do |merch|
      avg = average_item_price_for_merchant(merch.id)
      sum += average_item_price_for_merchant(merch.id)
    end
    (sum / @merchants.count).round(2)
  end

  def average_item_price
    sum = BigDecimal.new("0")
    @items.each { |item| sum += item.unit_price }
    sum / @items.count
  end

  def average_item_price_std_dev
    squared_diffs_sum = BigDecimal.new ("0")
    average = average_item_price
    items_minus_one = @items.count - 1
    @items.each do |item|
      squared_diffs_sum += (item.unit_price - average) ** 2
    end
    std_dev = (squared_diffs_sum / items_minus_one) ** 0.5
  end

  def golden_items
    golden_price = (average_item_price_std_dev * 2) + average_item_price
    golden_array = []
    @items.each do |item|
      golden_array << item if item.unit_price >= golden_price
    end
    golden_array
  end

end
