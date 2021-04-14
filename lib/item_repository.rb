require 'bigdecimal'
require 'CSV'
require 'time'

class ItemRepo

  def populate_information
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |item_info|
      items[item_info[:id]] = Item.new(item_info)
    end
      items
  end
end