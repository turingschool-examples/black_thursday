require 'csv'
require './lib/item.rb'

class SalesEngine

  def self.from_csv(data = {})
    @items = data[:items],
    @merchants = data[:merchants]
  end

end

# se = SalesEngine.new
# a = se.csv_reader('./data/items.csv')
# s = a.each do |row|
#   Item.new(row)
# end
