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

end
