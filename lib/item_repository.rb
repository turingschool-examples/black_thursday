require 'time'
require_relative './repository'
require_relative './item'

class ItemRepository < Repository

  def new_record(row)
    Item.new(row)
  end

  def find_all_with_description(item_description)
    @all.find_all do |item|
      item.description.upcase == item_description.upcase
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << new_item = Item.new(attributes)
    new_item
  end

  def update(id, attributes)
    item = find_by_id(id)
    return item if item.nil?
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
  end

end
