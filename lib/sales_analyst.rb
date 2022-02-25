class SalesAnalyst
  attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def list_all_items_by_merchant
    items_by_merchant = []

    @items.all.each do |item|
      items_by_merchant <<  @items.find_all_by_merchant_id(item.merchant_id)
    end
    items_by_merchant.uniq
  end

  def average_items_per_merchant
    all_items_by_merchant = list_all_items_by_merchant
    nums = []
    all_items_by_merchant.uniq.each { |sub_arr| nums << sub_arr.length }
    (nums.sum(0.0) / nums.length).round(2)
  end


  def average_items_per_merchant_standard_deviation
    all_items_by_merchant = list_all_items_by_merchant
    mean = average_items_per_merchant
    math_arr = []

    all_items_by_merchant.each { |sub_arr| math_arr << (sub_arr.length - mean) ** 2 }
    Math.sqrt((math_arr.sum)/474).round(2)
  end
end
