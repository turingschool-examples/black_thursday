require "pry"
require_relative 'item'

class ItemRepository
  attr_reader :items,
              :engine
  def initialize(csv, engine)
    @items = {}
    @engine = engine
    self.add(csv)
  end

  def add(csv)
    csv.each do |row|
      stuff = row.to_h
      items[stuff[:id].to_i] = Item.new(stuff, self)
    end
  end

  def all
    items.values
  end

  def find_by_id(id)
    items[id]
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(string)
    all.find_all do |item|
      item.description.to_s.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def merchant_by_item(merchant_id)
    engine.merchant_by_item(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
