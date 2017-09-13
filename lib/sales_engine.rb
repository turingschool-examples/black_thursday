require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'item'
require_relative 'merchant'
require 'csv'


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
      item_list << Item.new({ :id => id, :name => name, :description => description, :unit_price => unit_price, :created_at => created_at, :updated_at => updated_at, :merchant_id => merchant_id})
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
    self.read_items_file(items)
    self.read_merchants_file(merchants)
  end

end
