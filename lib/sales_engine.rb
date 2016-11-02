require 'pry'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require 'csv'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(hash)
    @items     =  ItemRepository.new(hash[:items], self)
    @merchants =  MerchantRepository.new(hash[:merchants], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end
