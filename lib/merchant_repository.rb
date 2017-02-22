require 'csv'
require 'pry'
require_relative 'merchant'

class MerchantRepository

  #creates instances of Merchant for each row in the csv file
  attr_reader

  def initialize(merchant_csv_data = "")
      create_merchant_instances(merchant_csv_data)
  end

  def create_merchant_instances(data)
    data.each do |row|
      all << Merchant.new({id: row[:id], name: row[:name]})
      end
   end

  def all
    []
  end

end
