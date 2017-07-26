require_relative 'merchant'
require_relative 'item'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants
  def from_csv(hash)
    @items = ItemRepository.new(hash[:items])
    @merchants = MerchantRepository.new(hash[:merchants])
  end


end
