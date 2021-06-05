class SalesEngine
  attr_reader :merchants_repo, :items_repo
  def initialize(paths)
    @items_repo = ItemRepository.new(paths[:items], self)
    @merchants_repo = MerchantRepository.new(paths[:merchants], self)
    # @analyst = SalesAnalyst.new
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end
end
