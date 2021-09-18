require 'csv'
require './lib/sales_engine'
require './lib/item'

class ItemRepository
  attr_reader :all

  def initialize(item_path)
    @all = (
      item_objects = []
      CSV.foreach(item_path, headers: true, header_converters: :symbol) do |row|
        item_objects << Item.new(row)
      end
    item_objects)

  end

  def find_by_id(id)
    if (@all.any? do |item|
      item.id == id
    end) == true
      @all.find do |item|
        item.id == id
      end
    else
      nil
    end
  end

  def find_by_name(name)
    if (@all.any? do |item|
      item.name == name
    end) == true
      @all.find do |item|
        item.name == name
      end
    else
      nil
    end
  end

  def find_all_with_description(description)
    if (@all.any? do |item|
      item.description == description
    end) == true
      @all.find do |item|
        item.description == description
      end
    else
      []
    end
  end 
end
