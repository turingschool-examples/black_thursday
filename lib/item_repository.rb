require './lib/item'
require 'time'
require 'pry'

class ItemRepository
  attr_reader :items_array
  def initialize(array_of_items)
    @items_array = array_of_items
  end

  def all
    @items_array
  end

  def find_by_id(id)
    findings = @items_array.find_all do |item|
      item.id == id
    end
    findings = nil if findings == []
    findings
  end

  def find_by_name(name)
    findings = @items_array.find_all do |item|
      item.name.downcase == name.downcase
    end
    findings = nil if findings == []
    findings
  end

  def find_all_with_description(description)
    findings = @items_array.find_all do |item|
      item.description =~ /#{description}/
    end
  end

  def find_all_by_price(price)
    findings = @items_array.find_all do |item|
      price == item.unit_price_to_dollars
    end
  end

  def find_all_by_price_in_range(range)
    findings = @items_array.find_all do |item|
      range.to_a.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    findings = @items_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    last_item = @items_array.last
    if last_item == nil
      max_id = 1
    else
      max_id = last_item.id + 1
    end
    attributes = {:id => max_id,
                  :name => attributes[:name],
                  :description => attributes[:description],
                  :unit_price => attributes[:unit_price],
                  :merchant_id => attributes[:merchant_id]}
    @items_array << Item.new(attributes)
  end

  def update(id, attributes)
    name = attributes[:name]
    description = attributes[:description]
    unit_price = attributes[:unit_price]
    item = find_by_id(id)
    item[0].name = name
    item[0].updated_at = Time.new.getutc
    item[0].description = description
    item[0].unit_price = unit_price
  end

  def delete(id)
    item = find_by_id(id)
    if item != []
      @items_array.delete_at(0)
    else
      "Item not found"
    end
  end
end
