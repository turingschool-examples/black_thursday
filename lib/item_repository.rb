require 'pry'
require 'CSV'
require './lib/merchant'

class ItemRepository

  def initialize(csv_items)
    @items = []
    create_item(csv_items)
  end

  def create_item(csv_items)
    row_objects = CSV.read(csv_items, headers: true, header_converters: :symbol)
      @items = row_objects.map do |row|
        Item.new(row)
      end
  end

  def all
    @items.count
  end

end
