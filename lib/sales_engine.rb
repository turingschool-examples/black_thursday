require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/sales_analyst.rb'

require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :analyst

  def initialize(merchant_location, item_location)
    @merchants = MerchantRepository.new(merchant_location)
    @items = ItemRepository.new(item_location)
    @analyst = SalesAnalyst.new(@merchants, @items)
  end

  def self.from_csv(csv_hash)
    merchant_location = csv_hash[:merchants]
    item_location = csv_hash[:items]
    SalesEngine.new(merchant_location, item_location)
  end
end
