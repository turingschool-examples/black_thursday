require "pry"
require_relative 'item'

class ItemRepository
  attr_reader :items
  def initialize(csv)
    @items = {}
    self.add(csv)
  end

  def add(csv)
    csv.each do |row|
      stuff = row.to_h
      items[stuff[:id]] = Item.new(stuff)
    end
  end

  def all
    items.values
  end

  def find_by_id(id)
    items[id]
  end

  def find_by_name(name)
    thing = items.find do |id, item|
      item.name == name
    end
    thing[1]
  end

  def find_all_with_description
    all.find_all do |item|
      !item.description.nil?
    end
  end
end
