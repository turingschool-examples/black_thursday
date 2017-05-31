require './lib/merchant_repository'
require './lib/item_repository'

class SearchEngine

  attr_reader :merchants, :items

  def initialize(item_merchant_hash)
    @items = ItemRepository.new(item_merchant_hash[:items])
    @merchants = MerchantRepository.new(item_merchant_hash[:merchants])
  end


end

se = SearchEngine.new({:items => "./data/items.csv", :merchants=>"./data/merchants.csv"})
p merchant = se.merchants
p items = se.items
