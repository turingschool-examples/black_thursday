require 'CSV'
require 'pry'
require './lib/item'
require './lib/black_thursday_helper'

class ItemsRepo
  include BlackThursdayHelper

  def initialize(file_path)
    @collections = []
    populate(file_path)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Item.new(params)
    end
  end

  def find_all_with_description(description)
    @collections.find_all do |object|
      object.description.downcase.include? (description.downcase)
    end
  end

  def find_all_by_price(price)
    @collections.find_all do |object|
      object.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @collections.keep_if do |object|
      range.include?(object.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @collections.find_all do |object|
      object.merchant_id == id
    end
  end

  def create(item_params)
    item = Item.new(item_params)
    highest_current = object_id_counter.id
    new_highest_current = highest_current += 1
    item.id = new_highest_current
    @collections << item
    item
  end

  def update(id, attributes)
      if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      object_to_be_updated.name = attributes[:name]
      object_to_be_updated.description = attributes[:description]
      object_to_be_updated.unit_price = attributes[:unit_price]
      object_to_be_updated.updated_at = Time.now
      else
        nil
      end
  end

end
