require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(item_file, merchant_file)
    @items = ItemRepository.new(item_file, self)
    @merchants = MerchantRepository.new(merchant_file, self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants])
  end

  def collected_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant(item_id)
    @merchants.merchant(item_id)
  end

end
