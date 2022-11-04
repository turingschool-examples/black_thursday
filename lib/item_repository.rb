require 'csv'
require_relative '../lib/item'
require 'bigdecimal'
class ItemRepository
  attr_reader :items, :engine

  def initialize(file = nil, engine = nil)
    @items = []
    @engine = engine
    load_data(file)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      # if the ids match
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      # the range includes the unit price
      # require 'pry' ; binding.pry

      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    sanitized_attributes = {
                            name:        attributes[:name],
                            description: attributes[:description],
                            unit_price:  attributes[:unit_price],
                            merchant_id: attributes[:merchant_id]
    }
    item = Item.new(sanitized_attributes)
    item.id = @items.max_by do |item|
      item.id
    end.id + 1
    item.created_at = Time.now
    item.updated_at = Time.now
    @items << item
    item
  end

  def update(id, attributes)
    return if attributes.empty?
    updated = find_by_id(id)
    updated.name = attributes[:name]
    updated.description = attributes[:description]
    updated.unit_price = attributes[:unit_price]
    updated.updated_at = Time.now
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def load_data(data)
    return nil unless data
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
