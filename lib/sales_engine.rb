require_relative 'item_repository'
require_relative 'merchants_repository'
require_relative 'data_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(merch_item_hash)
    @items = ItemRepository.new(merch_item_hash[:items])
    @merchants = MerchantsRepository.new(merch_item_hash[:merchants])
  end

  def self.from_csv(item_merch_hash)
    DataRepository.new(item_merch_hash)
  end

  def analyst(items, merchant)
    SalesAnalyst.new(items, merchants)
  end
end
