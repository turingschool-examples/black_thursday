require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader   :items,
                :merchants

  def initialize(filepath = nil)
    @items      = ItemRepository.new(filepath[:items], self)
    @merchants  = MerchantRepository.new(filepath[:merchants], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

end
