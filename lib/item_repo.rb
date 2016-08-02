require_relative './item'

class ItemRepo
  attr_reader :sales_engine

  def initialize(sales_engine = nil)
    @items = []
    @sales_engine = sales_engine
  end

  def all
    @items
  end

  def add(item_details)
    @items << Item.new(item_details, self)
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      # binding.pry
      item.unit_price_to_dollars == (price)
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  # all methods below this are for children querying into
  # other repos

  def find_merchant_by_merchant_id(id)
    @sales_engine.find_merchant_by_merchant_id(id)
  end

end
