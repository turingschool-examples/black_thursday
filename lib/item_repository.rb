# frozen_string_literal: true

require 'csv'
require_relative 'item'

# Defines ItemRepository, holding a list of Items
class ItemRepository
  def initialize(filename)
    @items = []
    load_csv filename
  end

  def load_csv(filename)
    CSV.foreach(
      filename,
      headers: true,
      header_converters: :symbol
    ) do |item_info|
      item = Item.new item_info
      @items.push item
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.select do |item|
      id == item.id
    end.first
  end
end
