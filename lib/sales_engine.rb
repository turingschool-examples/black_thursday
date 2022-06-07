require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_path, merchant_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchant_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
