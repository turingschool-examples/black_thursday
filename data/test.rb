require 'csv'

merchants = []

CSV.foreach("items.csv", headers: true, header_converters: :symbol) do |row|
  headers = row.headers
  merchants << row.to_h
end
