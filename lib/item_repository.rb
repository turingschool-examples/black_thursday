require 'csv'
require_relative 'item'
require 'pry'

# Creates and manages a database of items
class ItemRepository
  attr_reader :items

  def initialize(file_path)
    @items = []
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      @items.push(Item.new(row))
    end
  end
end
