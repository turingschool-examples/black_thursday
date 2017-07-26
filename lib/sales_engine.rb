require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def collected_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant(item_id)
    @merchants.merchant(item_id)
  end

end
