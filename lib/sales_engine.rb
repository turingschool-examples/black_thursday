class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_path, merchants_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
  end

  def self.from_csv(data)
    return SalesEngine.new(data[:items], data[:merchants])
  end

end
