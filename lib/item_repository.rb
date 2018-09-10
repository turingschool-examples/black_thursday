# require 'pry'

class ItemRepository

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def all
    items
  end

  def find_by_id(id)
    items.find {|item| item.id == id}
  end

  def find_by_name(name)
    items.find {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(description)
    items.find_all {|item| (item.description.include? description) == true }
  end

  def find_all_by_price(price)
    items.find_all {|item| item.unit_price_to_dollars == price.to_f}
  end

end
