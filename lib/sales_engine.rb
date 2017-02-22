require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  def self.from_csv(info)
    @merchant_repo = MerchantRepository.new(info[:merchants], self)
    @items_repo = ItemsRepository.new(info[:items], self)
    self
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @items_repo
  end


end

# se = SalesEngine.from_csv({
#     :merchants    => "./data/temp_merchants.csv",
#     })
# binding.pry
# merch = se.merchants
# merch.all
#
""
