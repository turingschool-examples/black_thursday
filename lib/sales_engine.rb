require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'item'
require_relative 'merchant'
require 'csv'

class SalesEngine
  def self.read_items_file(items)
    item_list =[]
    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      item_info = {}
      item_info[:id] = row[:id]
      item_info[:name] = row[:name]
      item_info[:description] = row[:description]
      item_info[:unit_price] = row[:unit_price]
      item_info[:created_at] =row[:created_at]
      item_info[:updated_at] = row[:updated_at]
      item_info[:merchant_id] = row[:merchant_id]
      item_list << Item.new(item_info)
    end
    ItemRepository.new(item_list, self)
  end

  def self.read_merchants_file(merchants)
    merchant_list = []
    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      merchant_list << Merchant.new({ :id => id, :name => name})
    end
    MerchantRepository.new(merchant_list, self)
  end

  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    item_repo = self.read_items_file(items)
    merchant_repo = self.read_merchants_file(merchants)
    sales_engine = SalesEngine.new(item_repo, merchant_repo)
  end

  attr_accessor :merchants, :items

  def initialize(items, merchants)
    @merchants = merchants
    @items = items
  end
end
