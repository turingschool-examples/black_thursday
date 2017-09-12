require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine 

  def self.from_csv(file_path)
    @items     = file_path[:items]
    @merchants = file_path[:merchants]
    self.merchants
    self.items
    self
  end

  def self.merchants 
    MerchantRepository.new(@merchants, self)
  end

  def self.items
    ItemRepository.new(@items, self)
  end
end
