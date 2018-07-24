require 'bigdecimal'
require 'pry'

class ItemRepository

  def initialize
    @items = []
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
     @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.cover?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end


  def create_with_id(attributes)
    item = Item.new(attributes)
    @items << item
    item
  end

  def create(attributes)
    item = Item.create(attributes)
    @items << item
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end



end
