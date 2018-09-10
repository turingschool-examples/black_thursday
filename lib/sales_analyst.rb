require_relative './merchant_repository'
require_relative './item_repository'

class SalesAnalyst
  attr_reader :mr, :ir

  def initialize
    @mr = MerchantRepository.new("./data/merchants.csv")
    @ir = ItemRepository.new("./data/items.csv")
  end

  def average_items_per_merchant

  end

  def average_items_per_merchant_standard_deviation

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
