require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine

  attr_reader   :items,
                :merchants

  def initialize(filepath = nil)
    @items      = ItemRepository.new(filepath[:items])
    @merchants  = MerchantRepository.new(filepath[:merchants])
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
