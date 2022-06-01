class SalesEngine
  attr_reader :item_collection, :merchant_collection

  def initialize(items_path, merchants_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
  end

  def self.from_csv(data)
    return SalesEngine.new(data[:items], data[:merchants])
  end

end
