require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'sales_analyst'

class SalesEngine
  def self.from_csv(file_hash)
    items = []
    CSV.foreach(file_hash[:items], headers: true, header_converters: :symbol) do |row|
      items << Item.new(row)
    end
    merchants = []
    CSV.foreach(file_hash[:merchants], headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end
    SalesEngine.new(items, merchants)
  end
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end

end
