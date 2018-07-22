require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item_repository.rb'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo

  def initialize(merchant_location, item_location)
    @merchant_repo = MerchantRepository.new(merchant_location)
    @item_repo = ItemRepository.new(item_location)
  end

  def self.from_csv(csv_hash)
    merchant_location = csv_hash[:merchants]
    item_location = csv_hash[:items]
    SalesEngine.new(merchant_location, item_location)
  end
end
