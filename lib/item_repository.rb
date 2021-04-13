# Basic ItemRepository class
class ItemRepository
  attr_reader :item_array

  def initialize(item_array)
    @item_array = item_array
  end

  def all
    @item_array
  end

  def find_by_id(id)
    @item_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @item_array.find do |item|
      item.name.downcase == name.downcase
    end
  end
end
