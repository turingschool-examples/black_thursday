require './lib/item'

class ItemRepo
  attr_reader :sales_engine

  def initialize(sales_engine = nil)
    @items = []
    @sales_engine = sales_engine
  end

  def all
    @items
  end

  def add_item(item_details)
    @items << Item.new(item_details, self)
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    name.downcase!
    @items.find do |item|
      item.name.downcase == name
    end
  end

  def find_all_with_description(description)
    description.downcase!
    @items.find_all do |item|
      item.description.downcase.include?(description)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

end
