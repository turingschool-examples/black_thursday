require_relative 'merchant'
require_relative 'item'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
