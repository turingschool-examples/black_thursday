require 'csv'
require './lib/item.rb'

class ItemRepository
  attr_reader :items

  def initialize(path, sales_engine = "")
    @items = []
    item_creator_and_storer(path)
  end

  def csv_opener(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def item_creator_and_storer(path)
    csv_opener(path).each do |item|
      @items << Item.new(item, self)
    end
  end

end
