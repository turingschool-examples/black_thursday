# sales_engine
require 'CSV'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/item'
require './lib/merchant'
require './lib/sales_analyst'

class SalesEngine
  attr_reader :item_repo, :merch_repo

  def initialize(items_, merchants_)
    @item_repo = ItemRepository.new(items_)
    @merch_repo = MerchantRepository.new(merchants_)
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
    SalesAnalyst.new(@item_repo.all, @merch_repo.all)
  end
end
