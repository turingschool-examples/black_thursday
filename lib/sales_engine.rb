class SalesEngine

  attr_reader :item_collection, :merchant_collection
  def initialize(items_path, merc_path)
    @item_collection = ItemCollection.new(items_path)
    @merchant_collection = MerchantCollection.new(merc_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end
end
