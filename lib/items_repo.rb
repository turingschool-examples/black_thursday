require './lib/items'
require 'csv'

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
end
