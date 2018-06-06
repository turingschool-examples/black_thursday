# frozen_string_literal: false

require_relative 'item'
require_relative 'repository'
# Responsible for holding and searching Item instances.
class ItemRepository
  include Repository
  attr_reader :items

  def initialize(items)
    @items = items
    @repository = []
    create_all_items
  end

  def create_all_items
    @items.each do |item|
      @repository << Item.new(item)
    end
  end

  def create(attributes)
    attributes[:id] = find_highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    unless item.nil?
      item.name        = attributes[:name] if attributes[:name]
      item.description = attributes[:description] if attributes[:description]
      item.unit_price  = attributes[:unit_price] if attributes[:unit_price]
      item.updated_at = Time.now
    end
    return nil
  end

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @repository.find_all do |item|
      price == item.unit_price
    end
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price)
    end
  end
end
