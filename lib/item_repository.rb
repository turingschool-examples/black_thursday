require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all = create_items(path)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def create_items(path)
    items = CSV.foreach(path, headers: true, header_converters: :symbol)
    items.map do |item|
      Item.new(item, self)
    end
  end

  def find_by_id(id)
    @all.find { |item| item.id == id }
  end

  def find_by_name(name)
    @all.find { |item| item.name.upcase == name.upcase }
  end

  def find_all_with_description(description)
    @all.find_all { |item| item.description == description }
  end

  def find_all_by_price(price)
    @all.find_all { |item| item.price == price }
  end

  def find_all_by_price_in_range(range)
    @all.find_all { |item| range.include?(item.price) }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    biggest = @all.max_by { |item| item.id }
    attributes[:id] = biggest.id + 1
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    @all << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    item[:name] = attributes[:name]
    item[:description] = attributes[:description]
    item[:unit_price] = attributes[:unit_price]
    item[:updated_at] = Time.now
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
