require 'csv'
# require 'merchants.csv'

merchants = []

CSV.foreach("items.csv", headers: true, header_converters: :symbol) do |row|
  headers = row.headers
  merchants << row.to_h
end

p merchants[1]
