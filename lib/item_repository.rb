require './item'
require 'CSV'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all = create_items(path)
  end

  def create_items(path)
    items = CSV.read(path, headers: true, header_converters: :symbol)
    items.map do |item_data|
      Item.new(item_data)
    end
  end

  def find_by_id(id)
    return nil unless
    @all.find_all do |item|
      if item.id == id
        return item.name
      end
    end
  end

end
