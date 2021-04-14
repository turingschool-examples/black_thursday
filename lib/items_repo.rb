require './lib/items'
require 'csv'
require 'bigdecimal'

class ItemRepo
  attr_reader :item_list

  def initialize(csv_files)
    @item_list = item_instances(csv_files)
  end

  def item_instances(csv_files)
    items = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @item_list = items.map do |item|
      Item.new(item)
    end
  end

  def all
    @item_list
  end

  def find_by_id(id)
    @item_list.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @item_list.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @item_list.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @item_list.find_all do |item|
      item.unit_price == price
    end
  end
end
