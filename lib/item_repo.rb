require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepo < CsvAdaptor

  attr_reader :data_file,
              :items

  def initialize(data_file, items=[])
    @data_file = data_file
    @items = items
  end

  def all_item_characteristics(data_file)
    load_items(data_file)
  end

  def all
    @items
  end

  # def load_all_items
  #   load_items(data_file).each do |item_info|
  #     @items << Item.new(item_info)
  #   end
  # end

  def find_by_id(id)
    @items.inject([]) do |items, item|
      if item.id == id
        return item
      else
      end
    end
  end

  def find_by_name(name)
    @items.inject([]) do |items, item|
      if item.name.downcase == name.downcase
        return item
      else
      end
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include? description.downcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      (item.unit_price >= range.begin) && (item.unit_price <= range.end)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_id = merchant_id.to_i
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_item_id
    @items.max_by do |item|
      item.id
    end.id.to_i
  end

  def create(attributes)
    item = Item.new(attributes)
    item.create_id(find_highest_item_id + 1)
    @items << item
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    new_name = attributes[:name]
    new_description = attributes[:description]
    new_unit_price = attributes[:unit_price]
    item.change_name(new_name)
    item.change_description(new_description)
    item.change_unit_price(new_unit_price)
    item.change_updated_at
    item
  end

  def delete(id)
    @items.delete_if do |item|
      item.id == id
    end
  end

  def item_array_from_file
    load_items(data_file).each do |item_info|
      @items << Item.new(item_info)
    end
  end

end
