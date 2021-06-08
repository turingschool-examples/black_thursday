require_relative '../spec/spec_helper'
require 'time'
require '../module/incravinable'

class ItemRepository
  include Incravinable

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_items(path)
    @engine = engine
  end

  def create_items(path)
    items = CSV.foreach(path, headers: true, header_converters: :symbol) do |item_data|
      data_hash = {
                    id: item_data[:id],
                    name: item_data[:name],
                    description: item_data[:description],
                    unit_price: item_data[:unit_price],
                    created_at: Time.parse(item_data[:created_at]),
                    updated_at: Time.parse(item_data[:updated_at]),
                    merchant_id: item_data[:merchant_id].to_i
                  }
      @all << Item.new(data_hash, self)
    end
  end

  def find_by_id(id)
    find_with_id(id, @all)
  end

  def find_by_name(name)
    find_with_name(name, all)
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    find_all_with_price(price, @all)
  end

  def find_all_by_price_in_range(range)
    find_all_with_price_in_range(range, @all)
  end

  def find_all_by_merchant_id(id)
    find_all_with_merchant_id(id, @all)
  end

  def create(attributes)
    highest_id = @all.max_by do |item|
      item.id
    end
    new_item = Item.new(attributes, self)
    new_item.new_id(highest_id.id + 1)
    @all << new_item
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      found_item = find_by_id(id)
      found_item.update_attributes(attributes)
      found_item.time_update
    end
  end

  def delete(id)
    remove(id, @all)
  end
end
