require 'CSV'
require './lib/item'

class ItemRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all =
      item_objects = []
      CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
        item_objects << Item.new(row)
      end
      item_objects
    end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

end
