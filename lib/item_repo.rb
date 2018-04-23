require_relative '../lib/item'
require_relative '../lib/load_file'
require 'pry'
class ItemRepo
  attr_reader :items,
              :contents,
              :parent

  def initialize(data, parent)
    @items = data.map {|row| Item.new(row, self)}
    @parent = parent
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
    
  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == BigDecimal.new(price)
    end
  end

  def find_all_by_price_in_range(price_range)
    items.find_all do |item|
    price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    items.find_all do |item| 
      item.merchant_id == id
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def find_max_id
    max = items.max_by { |item| item.id }
    max.id.to_i
  end

  def create(attrs)
    new_id = find_max_id + 1
    attrs[:id] = new_id.to_s
    attrs[:created_at] = Time.now
    attrs[:updated_at] = Time.now
    new_item = Item.new(attrs, self)
    items << new_item
    return new_item
     end

  def update(id, attrs)
    item_to_update = find_by_id(id)
    item_to_update.name = attrs[:name] unless attrs[:name].nil?
    item_to_update.description = attrs[:description] unless attrs[:description].nil?
    item_to_update.unit_price = BigDecimal.new(attrs[:unit_price]) unless attrs[:unit_price].nil?
    item_to_update.updated_at = Time.now unless item_to_update.nil?
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    items.delete(item_to_delete)
  end
end