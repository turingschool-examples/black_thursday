require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
  end

  def self.from_csv(hash_path)

    sales_engine = new

    rows = CSV.open hash_path[:merchants], headers: true, header_converters: :symbol
    rows.each do |row|
      new_merchant = Merchant.new(row.to_h)
      sales_engine.merchants.all << new_merchant
    end

    rows = CSV.open hash_path[:items], headers: true, header_converters: :symbol
    rows.each do |row|
      new_item = Item.new(row.to_h)
      sales_engine.items.all << new_item
    end



    sales_engine
  end
end
