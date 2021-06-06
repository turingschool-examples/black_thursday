require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(paths)
      @items = ItemRepository.new(paths[:items], self)
      @merchants = MerchantRepository.new(paths[:merchants], self)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end

  # def items
  #   @items_repo
  # end

  # def merchants
  #   @merchants_repo
  # end
end
