require 'CSV'
require './lib/item'
require './lib/merchant'
require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(files)
    instance = SalesEngine.new
    instance.load_items(files[:items])
    instance.load_merchants(files[:merchants])
    instance
  end

  def load_items(file_name)
    loaded_items = []
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
    @items = ItemRepository(loaded_items)
  end

  def load_merchants(file_name)
    loaded_merchants = []
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
    @merchants = MerchantRepository(loaded_merchants)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
