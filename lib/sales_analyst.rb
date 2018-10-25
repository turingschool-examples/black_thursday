
class SalesAnalyst
  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo.repo_array
    @items = item_repo.repo_array
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
    std_dev = average_items_per_merchant_standard_deviation
    high_count_merchs = []
    @merchants.each do |merch|
      if merchant_item_list(merch).count > std_dev
        high_count_merchs << merch
      end
    end
  end

end
