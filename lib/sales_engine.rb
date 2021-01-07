require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants])
    @items = ItemRepository.new(locations[:items])
  end

  def self.from_csv(locations)
    SalesEngine.new(locations)
  end

end
