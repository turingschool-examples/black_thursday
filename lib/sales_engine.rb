# sales_engine
require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_, merchants_)
    @items = ItemRepository.new(items_)
    @merchants = MerchantRepository.new(merchants_)
  end

  def self.from_csv(csv_hash)
    item_contents = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
    merchant_contents = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol

    # read file, create objects, return SE object
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
    SalesAnalyst.new(@items.all, @merchants.all)
  end
end
