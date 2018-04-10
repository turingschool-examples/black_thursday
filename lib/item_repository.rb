require 'csv'
require 'time'
require 'date'
require_relative 'item'

class ItemRepository
  attr_reader :items,
              :sales_engine

  def initialize(path, sales_engine)
    @items = []
    @sales_engine ||= sales_engine
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data, self)
    end
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

  def find_all_by_price_in_range(price_range)
    @items.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def create_new_id
    @items.map do |item|
      item.id
    end.max + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @items << Item.new(attributes,self)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.update_updated_at
    to_update.update_name(attributes[:name]) if attributes.keys.include?(:name)
    to_update.update_description(attributes[:description]) if attributes.keys.include?(:description)
    to_update.update_unit_price(attributes[:unit_price]) if attributes.keys.include?(:unit_price)
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
