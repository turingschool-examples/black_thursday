class SalesEngine

  attr_reader :merchants,
              :items

  def initialize(merch_item_hash)
    @merchants = MerchantsRepository.new(merch_item_hash[:merchants])
    @items = ItemRepository.new(merch_item_hash[:items])
  end

  def initialize(merch_item_hash)
    @merchants = MerchantsRepository.new(merch_item_hash[:merchants])
    @items = ItemRepository.new(merch_item_hash[:items])
  end
end
