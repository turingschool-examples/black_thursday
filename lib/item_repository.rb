require 'csv'
require_relative '../lib/item'
require_relative '../lib/modules/repo_queries'
require 'bigdecimal'

class ItemRepository
  include RepoQueries
  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    load_data(file)
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
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
    item.id = all.max_by do |item|
      item.id
    end.id + 1
    item.created_at = Time.now
    item.updated_at = Time.now
    all << item
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

  def child
    Item
  end
end
