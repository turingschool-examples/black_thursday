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
    ItemRepository.new(@items)
  end

  def merchants
    MerchantRepository.new(@merchants)
  end

  # def analyst
  #   SalesAnalyst.new
  # end

end
