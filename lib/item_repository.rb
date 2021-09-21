#require 'csv'

require_relative 'items'
require 'BigDecimal'
require 'Time'

class ItemRepository

  attr_reader :all

  def initialize(file)
    @all = fill_items(file)
  end

  def fill_items(file)
    all_items = CSV.parse(File.read(file))
    categories = all_items.shift
    all_items.map do |item|
      individual_item = {}
      categories.zip(item) do |category, attribute|
        individual_item[category.to_sym] = attribute
      end
      Item.new(individual_item)
    end
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end.uniq
  end

  def find_all_by_price(price)
    all.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    all.map do |item|
      item if range.include?(item.unit_price)
    end.compact
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id.to_i == merchant_id.to_i
    end
  end

  def create(attributes)
    creation_time = Time.now
    new_hash = {id: max_item.id + 1}
    attributes.each do |key, value|
      new_hash[key] = value
    end
    new_hash[:created_at] = "#{creation_time}"
    new_hash[:updated_at] = "#{creation_time}"
    all << Item.new(new_hash)
  end

  def max_item
    @all.max { |item1, item2| item1.id <=> item2.id }
  end

  def update(id, attributes)
    current_item = find_by_id(id)
    if !find_by_id(id).nil?
      all[all.find_index(current_item)] = current_item.update(attributes)
    end
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    position_of_item = all.find_index(item_to_delete)
    if !item_to_delete.nil?
      all.delete_at(position_of_item)
    end
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
