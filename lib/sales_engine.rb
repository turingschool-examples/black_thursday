require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv(data)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @sales_analyst = SalesAnalyst.new(self)
    self
  end

  def self.items
    @items
  end

  def self.merchants
    @merchants
  end

  def self.assign_item_count(id, num)
    @merchants.assign_item_count(id, num)
  end

end
