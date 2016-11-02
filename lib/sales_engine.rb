require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine

  attr_reader :items, :merchants

  def from_file(data)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

end