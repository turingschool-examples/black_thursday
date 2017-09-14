require_relative 'item'

class ItemRepository
  attr_reader :items
  def initialize(item_list)
    @items = item_list
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(word)
    items.find_all do |item|
      item.description.downcase.include?(word.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.cover?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
