require 'csv'

module ItemRepository

  lines = CSV.open "items.csv"
  lines.each do |line|
    puts line
  end
end
