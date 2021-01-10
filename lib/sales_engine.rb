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

  
