require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(items_filepath, merchants_filepath)
    @items = ItemRepository.new(items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
