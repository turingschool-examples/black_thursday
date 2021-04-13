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
      item.name.casecmp == name.casecmp
    end
  end

  def find_all_with_description(string)
    @item_array.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(amount)
    @item_array.find_all do |item|
      item.unit_price == amount
    end
  end

  def find_all_by_price_in_range(range)
    @item_array.find_all do |item|
      range.include?(item.unit_price)
    end
  end
end
