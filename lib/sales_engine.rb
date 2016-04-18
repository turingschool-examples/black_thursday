require 'csv'

class SalesEngine
  def from_csv
    # item_contents = CSV.open '../data/items.csv'
    merchants_contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol

    merchants_contents.each do |column|
      id = column[:id]
      name = column[:name]

      puts "#{id} and #{name}"
    end
  end
end

s = SalesEngine.new
s.from_csv
puts s
