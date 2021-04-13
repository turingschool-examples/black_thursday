require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'

# This class births all our repositories
class SalesEngine
  def initialize(file_hash)
    @location_hash = file_hash
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def items
    item_hash_new = Hash.new
    CSV.parse(File.read(@location_hash[:items]), headers: true).each do |item|
      item_hash_new[item[0]] = Item.new( id: item[0],
                                  name: item[1],
                                  description: item[2],
                                  unit_price: item[3],
                                  created_at: item[5],
                                  updated_at: item[6],
                                  merchant_id: item[4]
                                )
      end
      ItemRepository.new(item_hash_new)
  end

  def merchants
    merchant_array_new = []
    CSV.parse(File.read(@location_hash[:merchants]), headers: true).each do |merchant|
      merchant_array_new << Merchant.new( id: merchant[0],
                                          name: merchant[1],
                                          created_at: merchant[2],
                                          updated_at: merchant[3]
                                )
      end
      MerchantRepository.new(merchant_array_new)
  end
end
