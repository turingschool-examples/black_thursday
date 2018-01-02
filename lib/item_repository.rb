require 'csv'
require './lib/item.rb'

class ItemRepository

  def initialize(sales_engine)
    @items = []
    item_creator_and_storer
  end

  def csv_opener
    CSV.open './data/item.csv', headers: true, header_converters: :symbol
  end

  def item_creator_and_storer
    csv_opener.each do |item|
      @items << Item.new(item, self)
    end
  end

end
