require_relative 'item.rb'
require_relative 'repo_helper'

class ItemRepository
  include RepoHelper
  attr_reader :repo

  def initialize(file_contents)
    @repo = file_contents.map do |item|
      Item.new(item)
    end
  end

  def find_all_with_description(description)
    all_items = @repo.select do |item|
      item.description.downcase.include?(description.downcase)
    end
    return all_items
  end

  def find_all_by_price(price)
    all_items = @repo.select do |item|
      item.unit_price == price
    end
    return all_items
  end

  def find_all_by_price_in_range(range)
    all_items = @repo.select do |item|
      range.include?(item.unit_price)
    end
    return all_items
  end

  def find_all_by_merchant_id(merchant_id)
    all_items = @repo.select do |item|
      item.merchant_id == merchant_id
    end
    return all_items
  end

  def create(attributes)
    max_id = @repo.max_by do |item|
      item.id
    end # this returns the complete merchant object with highest id
    new_id = (max_id.id + 1).to_i
    attributes[:id] = new_id
    @repo << Item.new(attributes)
  end

  def update(id, attributes)
    new_name = attributes[:name]
    new_description = attributes[:description]
    new_unit_price = attributes[:unit_price]
    item = find_by_id(id)
    return if item.nil?
    item.updated_at = Time.now
    item.name = new_name
    item.description = new_description
    item.unit_price = new_unit_price
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
    item.attributes[key] = value
    item.attributes[:updated_at] = Time.now + 1
  end

  def update_unit_price(item, value)
    item.attributes[:unit_price] = value * 100
    item.attributes[:updated_at] = Time.now + 1
  end



end
