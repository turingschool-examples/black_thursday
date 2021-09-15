require 'csv'
require 'pry'
require './lib/merchant_repository'

class SalesEngine

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
      hash_of_stuff
  end

end
