require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/item'
require_relative '../lib/merchant'
require 'csv'
require 'pry'

class SalesEngine

  def self.read_items_file(items)
    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at =row[:created_at]
      updated_at = row[:updated_at]
      merchant_id = row[:merchant_id]
      binding.pry
      Item.new({ :id => id, :name => name, :description => description, :unit_price => unit_price, :created_at => created_at, :updated_at => updated_at})
    end
  end

  def self.read_merchants_file(merchants)
    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      binding.pry
      Merchant.new({ :id => id, :name => name})
    end
  end

  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    binding.pry
    read_items_file(items)
    read_merchant_file(merchants)
  end

end


SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
