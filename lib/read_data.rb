# require_relative 'merchant.rb'
require 'csv'

class ReadData 
  # creates an array of merchant_row objects
  def create_merchant_rows_from_csv 
    merchant_rows = []
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      merchant_rows << row
      #merchant_objects << Merchant.new(row)
    end 
    return merchant_rows
  end
  
  #creates array of item_row objects 
  # CAUTION! only 7 created 
  def create_item_rows_from_csv 
    item_rows = []
    CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |row|
      item_rows << row
    end 
    return item_rows
  end
end 

rd = ReadData.new 
p rd.create_merchant_rows_from_csv[0]
p rd.create_item_rows_from_csv[0]
p rd.create_merchant_rows_from_csv.count
p rd.create_item_rows_from_csv[0].count
