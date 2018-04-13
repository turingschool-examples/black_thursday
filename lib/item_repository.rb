# frozen_string_literal: true

require 'bigdecimal'
require 'time'
require_relative 'item.rb'
require_relative 'repository_helper.rb'
# require './lib/search.rb'
# require './lib/change_module.rb'
# This object holds all of the items. On initialization, we feed in the
# seperated out list of items, which we obtained from the CSV file. For each
# row, denoted here by the item variable, we insantiate a new item object that
# includes a reference to it's parent. We store this list in the item_list
# isntance variable, allowing us to reference the list outside of this class.
# The list is stored as an array.
class ItemRepository
  include RepositoryHelper
  attr_reader :repository,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent
  def initialize(items, parent)
    @repository = items.map { |item| Item.new(item, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by(&:id)
    @name = @repository.group_by(&:name)
    @description = @repository.group_by(&:description)
    @unit_price = @repository.group_by(&:unit_price)
    @merchant_id = @repository.group_by(&:merchant_id)
    @created_at = @repository.group_by(&:created_at)
    @updated_at = @repository.group_by(&:updated_at)
  end

  def find_by_name(name)
    @name[name].first unless @name[name].nil?
  end

  def find_all_with_description(item_description)
    @repository.find_all do |item|
      item.searchable_desc == item_description.downcase
    end
  end

  def find_all_by_price(price)
    if @unit_price[price].nil?
      return []
    else
      @unit_price[price]
    end
  end

  def find_all_by_price_in_range(price_range)
    @repository.find_all do |item|
      price_range.include?(item.item_specs[:unit_price])
    end
  end

  def create(attributes)
    attributes[:id] = (@id.keys.last + 1)
    @repository << Item.new(attributes, self)
    build_hash_table
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @repository.delete(item_to_delete)
    build_hash_table
  end

  def update(id, attributes)
    item = find_by_id(id)
    unchangeable_keys = %i[id item_id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if item.item_specs.keys.include?(key)
        item.item_specs[key] = value
        item.item_specs[:updated_at] = Time.now
      end
    end
    build_hash_table
  end

  def find_merchant_by_merchant_id(merchant_id)
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
