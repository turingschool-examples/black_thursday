require 'csv'
require_relative 'item'
class ItemRepository
  attr_reader :items

  def initialize(filepath)
    @items = []
    find_items(filepath)
  end

  def find_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end
end
