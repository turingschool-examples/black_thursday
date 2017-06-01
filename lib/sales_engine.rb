require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
# require_relative 'csv_reader'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(hash)
    @items = ItemRepository.new(hash[:items])
    @merchants = MerchantRepository.new(hash[:merchants])
  end

  def self.from_csv(hash)
    se = SalesEngine.new(hash)
  end

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })

end
