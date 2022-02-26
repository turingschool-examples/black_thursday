#sales_engine
require 'CSV'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
  end

  def self.from_csv(csv_hash)
    item_contents = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
    merchant_contents = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol

    #read file, create objects, return SE object
    items = []
    item_contents.each do |row|
      items << Item.new(row)
    end

    merchants = []
    merchant_contents.each do |row|
      merchants << Merchant.new(row)
    end

    se = SalesEngine.new(items, merchants)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
