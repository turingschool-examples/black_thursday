require_relative 'item.rb'
require_relative 'repository_helper.rb'
require 'pry'

class ItemRepository
  include RepositoryHelper
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |item| Item.new(item) }
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

  def create(attributes)
    sorted = @repository.sort_by(&:id) # { |item| item.id }
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    @repository << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    return if item.nil?
    attributes.each do |key, value|
      update_name_or_desc(item, key, value) if key == :name || key == :description
      update_unit_price(item, value) if key == :unit_price
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

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
