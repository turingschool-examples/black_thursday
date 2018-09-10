require_relative './merchant_repository'
require_relative './item_repository'

class SalesAnalyst
  attr_reader :mr, :ir

  def initialize
    @mr = MerchantRepository.new("./data/merchants.csv")
    @ir = ItemRepository.new("./data/items.csv")
  end

  def average_items_per_merchant
    (@ir.all.count.to_f/@mr.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    hash = Hash.new(0)
    @ir.all.each do |item|
      hash[item.merchant_id] += 1
    end 

  end

  def merchants_with_high_item_count

  end

  def average_item_price_for_merchant(merchant_id)

  end

  def average_average_price_per_merchant

  end

  def golden_items

  end


end
