require './lib/item'

class ItemRepository

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(item_id)
    items.find do |item|
      item.id == item_id
    end
  end

  def find_by_name(item_name)
    items.find do |item|
      item.name == item_name
    end
  end

  def find_all_with_description(string_description)
    items.find_all do |item|
      item.description.downcase.include?(string_description.downcase)
    end
  end

  def find_all_by_price

  end

end
