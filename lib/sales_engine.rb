require 'csv'
require_relative '../lib/merchant_repository'
# require_relative '../lib/item_repository'

class SalesEngine

  def from_file(data)
    insert_item_repository(data[:items])
    insert_merchant_repository(data[:merchants])
  end

  def insert_merchant_repository(file_path)
    merchants_data = CSV.read(file_path, headers:true)
    merchants_collection = []  
    merchants_data.foreach do |row|
      merchants_collection << Merchant.new({:id => row[:id], :name => row[:name]})
    end
    @merchants = MerchantRepository.new(merchants_collection)
  end

  def insert_item_repository(file_path)
    true
  end

end