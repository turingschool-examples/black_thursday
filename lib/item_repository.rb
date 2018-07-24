# frozen_string_literals: true

require 'bigdecimal'

# ./lib/item_repository
class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(search_id)
    @items.find { |item| item.id == search_id }
  end

  def find_by_name(search_name)
    @items.find { |item| item.name == search_name }
  end

  def find_all_with_description(partial_description)
    @items.find_all do |item|
      item_description = item.description.downcase
      item_description.include?(partial_description.downcase)
    end
  end

  def find_all_by_price(search_price)
    @items.find_all { |item| item.unit_price == search_price }
  end

  def find_all_by_price_in_range(search_price_range)
    @items.find_all do |item|
      search_price_range.cover?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(search_id)
    @items.find_all { |item| item.merchant_id == search_id }
  end

  def create_with_id(attributes)
    @items << Item.new(attributes)
  end

  def create(attributes)
    @items << Item.create(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end
end
