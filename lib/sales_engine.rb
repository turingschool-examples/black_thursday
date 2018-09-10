require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'sales_analyst'
class SalesEngine
    attr_reader :merchants, :items

  def initialize(path_1, path_2)
    @merchants = MerchantRepository.new(path_2)
    @items = ItemRepository.new(path_1)
  end

  def self.from_csv(data)
    self.new(data[:items], data[:merchants])
  end

  def analyst
    @sales_analyst = SalesAnalyst.new(self)
  end
end
