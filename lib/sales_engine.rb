require 'csv'
require 'pry'
require './lib/merchant_repository'

class SalesEngine
  attr_reader  :merchants,
               :items

  def self.from_csv(data)
      all_item_data = []
      CSV.foreach(data[:items], headers: true) do |row|
        all_item_data << row.to_hash
      end
      all_merchant_data = []
      CSV.foreach(data[:merchants], headers: true) do |row|
        all_merchant_data << row.to_hash
      end
      hash_of_stuff = {:items => all_item_data,
                       :merchants => all_merchant_data}
      SalesEngine.new(hash_of_stuff)
  end

  def initialize(data)
    @merchants = MerchantRepository.new(data[:merchants])
    @items = ItemRepository.new(data[:items])
  end

end
