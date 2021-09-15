require 'csv'

headers = []
CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol) do |row|
    headers << row
end

names = headers.map do |name|
    name[:name]
end

p names
