require './lib/item'
require 'pry'
class ItemRepository
  include TypeConversion

  attr_reader :list_of_items

  def initialize(items_data)
    @list_of_items = []
    populate_items(items_data)
  end

  def populate_items(items_data)
    @list_of_items = items_data.map do |datum|
      Item.new(datum)
    end
  end

  def all
    list_of_items
  end

  def find_by_id(id_to_find)
    @list_of_items.find do |item|
      item.id == id_to_find.to_s
    end
  end

  def find_by_name(name_to_find)
    @list_of_items.find do |item|
      item.name.downcase == name_to_find.downcase
    end
  end

  def find_all_by_description(description_fragment_to_find)
    @list_of_items.find_all do |item|
      item.description.downcase.include?(description_fragment_to_find.downcase)
    end
  end

  def find_all_by_price(price_to_find)
    big_decimal_to_find = convert_to_big_decimal(price_to_find)
    @list_of_items.find_all do |item|
      item.unit_price == big_decimal_to_find
    end
  end

  def find_all_by_price_in_range(range_to_find_from)
    @list_of_items.find_all do |item|
      range_to_find_from.include?(convert_to_integer(item.unit_price))
    end
  end

  def find_all_by_merchant_id(merchant_id_to_find)
    @list_of_items.find_all do |item|
      item.merchant_id == merchant_id_to_find
    end
  end

end
