require_relative 'merchant.rb'
require 'csv'

class ReadData 
  def create_merchants_from_csv 
    merchant_rows = []
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      merchant_rows << row
      #merchant_objects << Merchant.new(row)
    end 
    return merchant_rows
  end
end 

rd = ReadData.new 
p rd.create_merchants_from_csv[0]
