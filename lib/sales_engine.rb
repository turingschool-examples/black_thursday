require 'pry'
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
  end

  def find_items_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end
end
binding.pry
