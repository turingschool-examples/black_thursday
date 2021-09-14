require 'csv'
require './lib/itemrepository'
require './lib/merchant_repository'

class SalesEngine
  def self.from_csv
    @item_path = "./data/items.csv"
    @merchant_path = "./data/merchants.csv"
  end

  # def initialize
  #   @item_repository = ItemRepository.new
  #   @merchant_repository = MerchantRepository.new
  # end
end
