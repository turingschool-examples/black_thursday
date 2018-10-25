require 'csv'
require_relative './item'
require 'bigdecimal'
require 'time'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def from_csv(file_path)
    raw_items_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_items_data.map do |raw_item|
      Item.new(raw_item.to_h)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
       item.unit_price_to_dollars >= price_range.first && item.unit_price_to_dollars <= price_range.last
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    highest_item = @all.max {|item| item.id}
    attributes[:id] = highest_item.id + 1
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.now.to_s
    @all << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name] if attributes[:name]
    item.unit_price = attributes[:unit_price] if attributes[:unit_price]
    item.description = attributes[:description] if attributes[:description]
    item.updated_at = Time.new.getutc if item 
  end

  def delete(id)
    item = find_by_id(id)
    @all.delete(item)
  end
end
