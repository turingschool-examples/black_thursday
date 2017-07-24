require 'csv'
require 'pry'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def from_csv(path)
    contents = CSV.open path, headers: true, header_converters: :symbol
    contents.each do |data|
      # item.add_data(data)
    end
  end







end

# se = SalesEngine.from_csv("./data/items.csv")
binding.pry
