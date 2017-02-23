require_relative './item_repository'
require_relative './merchant_repository'

class SalesEngine

  attr_accessor :items, :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items])
    @merchants = MerchantRepository.new(hash[:merchants])
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

end


# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# require "pry"; binding.pry
# p ""
