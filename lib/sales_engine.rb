require 'csv'
require 'pry'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :merchants

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
  end

  def from_csv(input)
    input.each_pair do |key, value|
      load_csv(value, key)
    end
  end

  def open_csv(path)
    contents = CSV.open path, headers: true, header_converters: :symbol
    contents.each do |data|
    @merchants.add_data(data)
        # puts data
        # puts "\n\n END DATA \n\n"
    end
  end





end

# se = SalesEngine.open_csv("./data/items.csv")

binding.pry
