require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item_repository.rb'
require 'pry'

class SalesEngine
  def self.from_csv(csv_hash)
    merchant_data = csv_hash[:merchants]
    item_data = csv_hash[:items]
    SalesEngine.new(merchant_data, item_data)
  end

  def initialize(merchant_data, item_data)
    @merchants = MerchantRepository.new(merchant_data)
    @items = ItemRepository.new(item_data)
  end
end
