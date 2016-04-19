require './lib/item'

class ItemRepository

  attr_accessor :items

  def initialize
    @items = []
  end

  def <<(item_obj)
    @items.push(item_obj)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(partial)
    matches = @items.find_all do |item|
      item.description.downcase.include?(partial.downcase)
    end
    if matches.nil?
      []
    else
      matches
    end
  end

  def find_all_by_price(price)
    matches = @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
    if matches.nil?
      []
    else
      matches
    end
  end

  def find_all_by_price_in_range(range)
    matches = @items.find_all do |item|
      item.unit_price_to_dollars >= range.begin &&
      item.unit_price_to_dollars <= range.end
    end
    if matches.nil?
      []
    else
      matches
    end
  end


  def find_by_merchant_id(id)
    @items.find do |item|
      item.merchant_id == id
    end
  end

end
