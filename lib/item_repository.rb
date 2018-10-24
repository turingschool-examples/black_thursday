require 'csv'
require './lib/item'
require 'pry'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def from_csv(file_path)
    raw_items_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_items_data.map do |raw_item|
      Item.new(raw_item.to_h)
    end
  end

  def find_by_id(item_id)
    @all.find do |item|
      item.id == item_id
    end
  end

end
