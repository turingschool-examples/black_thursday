require 'csv'
require 'pry'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def from_csv(input)
    input.each_pair do |key, value|
      load_csv(value, key)
    end
  end

  def load_csv(path, repo)
    contents = CSV.open path, headers: true, header_converters: :symbol
    contents.each do |data|
    repo.add_data(data)
    end
  end





end

# se = SalesEngine.from_csv("./data/items.csv")
binding.pry
