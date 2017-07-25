require 'CSV'
require './lib/item_repository'
require './lib/merchant_repository'
require 'pry'

class SalesEngine

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

  def items
    
  end

  # def fetch_items(id)
  #   items.find_all_by_merchant_id(id)
  # end

  # def items_2
  #   # merchant_id = self.id
  #   items.find_all_by_merchant_id(merchant_id)
  # end

end