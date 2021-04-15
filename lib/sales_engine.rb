require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'

# This class births all our repositories
class SalesEngine
  def initialize(file_hash)
    @location_hash = file_hash
    @items_instance = ItemRepository.new(@location_hash, self)
    @merchants_instance = MerchantRepository.new(@location_hash, self)
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def items
    @items_instance
  end

  def merchants
    @merchants_instance
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
