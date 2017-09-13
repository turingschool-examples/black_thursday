require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine 
  attr_reader :items, :merchants 

  def initialize(file_path)
    @merchants = MerchantRepository.new(file_path[:merchants], self)
    @items     = ItemRepository.new(file_path[:items], self)
  end

  def self.from_csv(file_path)
   SalesEngine.new(file_path)
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_that_owns_item(item_id)
    @merchants.find_by_id(item_id)
  end
end