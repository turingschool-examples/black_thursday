require 'csv'
require './lib/item_repository'

class SalesEngine
  def self.from_csv(files_to_parse = {})
    item_file = files_to_parse.fetch(:items)
    item_contents = CSV.open item_file, headers: true, header_converters: :symbol

    merchant_file = files_to_parse.fetch(:merchants)
    merchants_contents = CSV.open merchant_file, headers: true, header_converters: :symbol

    merchants_contents.each do |column|
      id = column[:id]
      name = column[:name]
    end

    store = ItemRepository.new( item_contents.map do |column|
      item = Item.new({
        :id => column[:id],
        :name => column[:name],
        :description => column[:description],
        :unit_price => column[:unit_price],
        :merchant_id => column[:merchant_id],
        :created_at => column[:created_at],
        :updated_at => column[:updated_at],
       })
     end
     )
    store.all
  end
end

s = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
