class SalesEngine
  attr_reader :item_repository, :merchant_repository, :analyst

  def initialize(items_path, merchants_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @analyst = SalesAnalyst.new(@item_repository, @merchant_repository)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items],data[:merchants])
  end


end
