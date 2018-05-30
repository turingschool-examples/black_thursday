require_relative 'item.rb'
require 'pry'

class ItemRepository
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |item| Item.new(item) }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |item| item.id == id}
  end

  def find_by_name(name)
    @repository.find { |item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(description)
    @repository.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @repository.select { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @repository.select { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    sorted = @repository.sort_by { |item| item.id }
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    @repository << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    if item != nil
      attributes.each do |key, value|
        update_name_or_desc(item, key, value) if (key == :name || key == :description)
        update_unit_price(item, value) if key == :unit_price
      end
    end
  end

  def update_name_or_desc(item, key, value)
    item.specs[key] = value
    item.specs[:updated_at] = Time.now + 1
  end

  def update_unit_price(item, value)
    item.specs[:unit_price] = value * 100
    item.specs[:updated_at] = Time.now + 1
  end

  def delete(id)
    item = find_by_id(id)
    @repository.delete(item)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
