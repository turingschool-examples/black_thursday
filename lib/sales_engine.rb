class SalesEngine
  attr_reader :item_repository, :merchant_repository

  def initialize(items_path, merchants_path)
    # @item_repository = ItemCollection.new(items_path)
    @merchant_repository = Merchant_Repository.new(merchants_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items],data[:merchants])

  end


end
