require 'csv'
require 'pry'
require './lib/merchant'

contents = CSV.open "./fixtures/merchant_single.csv", headers: true, header_converters: :symbol

contents.each do |row|
  id = row[:id]
  name = row[:name]
  created_at = row[:created_at]
  updated_at = row[:updated_at]
  details = {:id => id, :name => name, 
             :created_at => created_at,
             :updated_at => updated_at}
  merchant = Merchant.new(details)
  binding.pry
end