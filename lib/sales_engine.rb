require 'pry'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants  = MerchantRepository.new
    @items      = ItemRepository.new
  end
end
