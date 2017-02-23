require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_accessor :merchants, :items

  def self.from_csv(info)
    @merchants_repo = MerchantRepository.new(info[:merchants], self)
    @items_repo = ItemRepository.new(info[:items], self)
    self
  end

  def self.merchants
    @merchants_repo
  end

  def self.items
    @items_repo
  end


end

# se = SalesEngine.from_csv({
#     :merchants    => "./test/fixtures/temp_merchants.csv",
#     :items => "./test/fixtures/temp_items.csv"
#     })
# binding.pry
# merch = se.merchants
# merch.all

""
