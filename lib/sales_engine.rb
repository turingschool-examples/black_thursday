require_relative './item_repository'
require_relative './merchant_repository'
require_relative './item'
require_relative './merchant'
require 'csv'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(paths)
    if !paths[:items].nil?
      @items = ItemRepository.new(paths[:items], self)
      @items.generate
    end
    if !paths[:merchants].nil?
      @merchants = MerchantRepository.new(paths[:merchants], self)
      @merchants.generate
    end
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
