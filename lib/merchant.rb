require 'csv'


content = CSV.open './data/items.csv', headers: true, header_converters: :symbol
content.each do |row|
  puts row[:name]
end