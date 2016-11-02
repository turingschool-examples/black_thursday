require './lib/merchant_repo'
require './lib/item_repo'
require 'pry'

class SalesEngine
  def self.from_csv(file)
    @items     = ItemRepo.new
    @merchants = MerchantRepo.new
    self
  end

  def self.merchants
    @merchants
  end

  def self.items
    @items
  end
end

# se = SalesEngine.from_csv
# mr = se.merchants
# merchant = mr.find_by_name("fancybookart")
# p merchant
