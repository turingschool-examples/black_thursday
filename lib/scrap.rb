
require 'csv'
require_relative './merchant'


# CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
#   Merchant.new(row)
# end 
# p @array[0]
@merchants = [] 
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    @merchants << Merchant.new(row)
  end  
  
p @merchants[0]
 
 
