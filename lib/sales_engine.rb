class SalesEngine
  include Math

  attr_reader :merchants,
              :items

  def initialize(csv_data)
    make_merchant_repo(csv_data)
    make_item_repo(csv_data)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

  def find_items_by_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_average
    (items.item_list.count.to_f / merchants.merchant_list.count.to_f).round(2)
  end

  def standard_deviation
    total_count = @merchants.merchant_list.reduce([]) do |acc, merchant|
      acc << merchant.item_name.count
      acc
    end

    sum = total_count.sum do |value|
      ((value - find_average)**2)
    end
    result = (sum / 475)

    Math.sqrt(result).round(2)
  end

  def find_merchants_with_most_items
    total_count = @merchants.merchant_list.reduce({}) do |acc, merchant|
      acc[merchant] = merchant.item_name.count
      acc
    end

    total_count.select do |key, value|
      value >= 7
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def make_merchant_repo(csv_data)
    @merchants = MerchantRepo.new(csv_data[:merchants], self)
  end

  def make_item_repo(csv_data)
    @items = ItemRepo.new(csv_data[:items], self)
  end
end








  # most_common_merchant_id_number_array = []
  # item_list = []
  # @sales_engine.items.item_list.each do |item|
  #   item_list << item.merchant_id
  # end
  # until most_common_merchant_id_number_array.length == 3
  #   this_is_the_most_common_merchant =  item_list.max_by {|merchant_id|item_list.count(merchant_id)}
  #   most_common_merchant_id_number_array << this_is_the_most_common_merchant
  #   item_list.delete(this_is_the_most_common_merchant)
  # end
  # answer = []
  # @sales_engine.items.item_list.each do |item|
  #     most_common_merchant_id_number_array.each do |most_common|
  #     if most_common == item
  #       answer << item
  #     end
  #   end
  # end
  # answer.flatten
  # end
