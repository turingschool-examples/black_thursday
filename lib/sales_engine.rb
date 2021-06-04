require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  def initialize(path)
    @items = ItemRepository.new(path[:items])
    @merchants = MerchantRepository.new(path[:merchants])
  end

  def self.from_csv(path)
    new(path)
  end

  # def items
  #
  # end

  # def merchants
  #   (@merchants)
  # end

  # def analyst
  #   SalesAnalyst.new
  # end

end
