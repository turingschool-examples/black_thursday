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
end
