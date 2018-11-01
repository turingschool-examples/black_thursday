require_relative './item'
class ItemRepository
  attr_reader :all
  def initialize
    @all = []
  end

  def create(info)
     new_item = Item.new(info)
     @all << new_item
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(desc)
    @all.find_all do |item|
      item.description == desc
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |item|
      item.merchant_id == id
    end
  end

  def update(id, info)
    found = find_by_id(id)
    found.update(info)
  end
end
