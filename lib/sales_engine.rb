require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require './lib/item'
require 'CSV'

class SalesEngine
  attr_reader :items_file,
              :merchants_file

  def initialize(file_path_hash)
    @items_file = file_path_hash[:items]
    @merchants_file = file_path_hash[:merchants]
    @file_path_hash = file_path_hash
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def merchants
    array_of_merchants = merchant_csv_converter(@merchants_file)
    MerchantRepository.new(array_of_merchants)
  end

  def items
    array_of_items = item_csv_converter(@items_file)
    ItemRepository.new(array_of_items)
  end

  def merchant_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      Merchant.new(obj.to_h)
    end
  end

  def item_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:merchant_id] = obj[:merchant_id].to_i
      Item.new(obj.to_h)
    end
  end
end
