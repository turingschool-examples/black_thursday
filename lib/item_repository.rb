require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(items_data)
    @items = {}
    populate(items_data)
  end

  def format_item_info(item)
    { :id          => item[:id],
      :name        => item[:name],
      :description => item[:description],
      :unit_price  => item[:unit_price],
      :created_at  => item[:created_at],
      :updated_at  => item[:updated_at],
      :merchant_id => item[:merchant_id] }
  end

#*****  check simplecov test coverage to inlcude #make_item ******
  def make_item(item_data)
    item_formatted = format_item_info(item_data)
    @items[item_data[:id]] = Item.new(item_formatted)
  end

  def populate(items_data)
    items_data.each do |item_data|
      make_item(item_data)
    end
  end

  def all
    items.values
  end

  def find_by_id(item_id)
    items[item_id]
  end

  def find_by_name(item_name)
    items.values.find do |item|
      item.name.downcase == item_name.downcase
    end
  end

  def find_all_with_description(description_fragment)
    items.values.find_all do |item|
      item.description.downcase.include?(description_fragment.downcase)
    end
  end

  def find_all_by_price(item_price)
    items.values.find_all do |item|
      item.unit_price == item_price
    end
  end

  def find_all_by_price_in_range(price_range)
    items.values.find_all do |item|
      price_range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.values.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
