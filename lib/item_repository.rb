require 'pry'
require 'csv'
require_relative 'item'

# This is an item repository class
class ItemRepository
  attr_reader :item_list, :parent, :items

  def initialize(item_csv, parent)
    @parent = parent
    @items = []

    csv_file = CSV.open(item_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @items << Item.new(row)
    end
  end
end
