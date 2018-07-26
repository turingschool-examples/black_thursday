require 'csv'
require_relative './item'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './sales_analyst'  

class SalesEngine
  attr_reader :csv_hash,
              :items,
              :merchants

  def initialize(csv_hash)
    @csv_hash = csv_hash
    @items = ItemRepository.new(csv_hash[:items])
    @items.create_items
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    @merchants.create_all_from_csv(csv_hash[:merchants])
  end

  def self.from_csv(csv_hash)#pass in result of read_from_csv
    SalesEngine.new(csv_hash)
  end
  
  def analyst 
    SalesAnalyst.new 
  end 
end
