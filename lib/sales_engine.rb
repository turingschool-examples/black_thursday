require './merchant_repo'
require './item_repo'
require './item'
require './merchant'
require 'csv'
require 'pry'

class SalesEngine

  def self.read_items_file(items)
    item_list =[]
    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at =row[:created_at]
      updated_at = row[:updated_at]
      merchant_id = row[:merchant_id]
      item_list << Item.new({ :id => id, :name => name, :description => description, :unit_price => unit_price, :created_at => created_at, :updated_at => updated_at})
    end
    ItemRepository.new(item_list)
  end

  def self.read_merchants_file(merchants)
    merchant_list = []
    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      merchant_list << Merchant.new({ :id => id, :name => name})
    end
    MerchantRepository.new(merchant_list)
  end

  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    read_items_file(items)
    read_merchant_file(merchants)
  end

end


SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
