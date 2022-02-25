require 'pry'
require 'csv'
require './lib/item'
require './lib/merchant'

class SalesEngine
  attr_reader :items_csv_object, :merchants_csv_object
  def initialize(table_hash)
      @items_csv_object = table_hash[:items]
    @merchants_csv_object = table_hash[:merchants]
  end

  def self.from_csv(path_hash)
    table_hash = Hash.new
    path_hash.each do |name, path|
      csv = CSV.read(path, headers: true, header_converters: :symbol)
      table_hash[name] = csv
    end
    SalesEngine.new(table_hash)
  end

  def items
    item_array = @items_csv_object.map do |row|
      Item.new(row)
    end
    ItemRepository.new(item_array)
  end

  def merchants
    merchant_array = @merchants_csv_object.map do |row|
      Merchant.new(row)
    end
    MerchantRepository.new(merchant_array)
  end  
end
