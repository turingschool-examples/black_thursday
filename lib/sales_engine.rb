require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine

  attr_accessor :items, :merchants

  def self.from_csv(data)
    engine = SalesEngine.new
    engine.items = ItemRepository.new(data[:items], self)
    engine.merchants = MerchantRepository.new(data[:merchants], self)
    engine
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

end