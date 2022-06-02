class SalesEngine

  attr_reader :merchants, :items

  def initialize(items_path, merchants_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end

end
