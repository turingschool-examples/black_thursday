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


  def average_items_per_merchant_standard_deviation
    std_dev_arr = list_all_items_by_merchant
    nums = []

    std_dev_arr.uniq.each { |sub_arr| nums << sub_arr.length }

    mean = nums.sum(0.0) / nums.length
    math_arr = []

    std_dev_arr.each { |sub_arr| math_arr << (sub_arr.length - mean) ** 2 }
    Math.sqrt((math_arr.sum)/474).round(2)
  end
end
