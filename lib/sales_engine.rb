require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  def self.from_csv(path)
    @items = path[:items]
    @merchants = path[:merchants]
    SalesEngine.new
  end

  def items
    item_repository = ItemRepository.new(@items)
  end

  def merchants
    merchant_repository = MerchantRepository.new(@merchants)
  end

  # def analyst
  #   SalesAnalyst.new
  # end

end
