require 'pry'
require 'csv'
require_relative './item'
require_relative './merchant'

class SalesEngine
  attr_reader :table_hash
  def initialize(table_hash)
    @table_hash = table_hash  
  end

  def self.from_csv(path_hash)
    table_hash = {}
    path_hash.each do |name, path|
      csv = CSV.read(path, headers: true, header_converters: :symbol)
      table_hash[name] = csv
    end
    SalesEngine.new(table_hash)
  end

  def items
    item_array = @table_hash[:items].map do |row|
      Item.new(row)
    end
    ItemRepository.new(item_array)
  end

  def merchants
    merchant_array = @table_hash[:merchants].map do |row|
      Merchant.new(row)
    end
    MerchantRepository.new(merchant_array)
  end
end
