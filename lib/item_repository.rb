require 'csv'

class ItemRepository

  attr_reader :items_csv

  def initialize
    @items_csv = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @create_items = 
    @items = {}
  end

  def all

  end

end
