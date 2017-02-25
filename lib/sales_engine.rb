require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'


class SalesEngine
  attr_accessor :items, :merchants

  def initialize(file_hash)
    @items = ItemRepository.new(self, file_hash[:items])
    @merchants = MerchantRepository.new(self, file_hash[:merchants])
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def number_of_merchants
    merchants.count
  end

  def number_of_items
    items.count
  end

  def number_of_items_per_merchant
    total = items.data.group_by(&:merchant_id).values.map(&:count)
  end

end
