require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader   :items,
                :merchants

  def self.from_CSV(paths)
    @items = ItemRepository.new(paths[:items])
#    @merchants = MerchantRepository.new(paths[:merchants])
  end

end

se = SalesEngine.from_CSV({
  :items     => "./fixture/items.csv",
#  :merchants => "./data/merchants.csv"
})

binding.pry