class SalesEngine
  def self.from_csv(hash)
    SalesEngine.new(hash[:items], hash[:merchants])
  end

  def initialize(items_location, merchant_location)
    @items = ItemRepository.new(items_location)
    @merchants = MerchantRepository.new(merchant_location)
  end
end
