require 'csv'
require_relative 'item'

class ItemRepository
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
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

  def find_all_with_description(my_description)
    @items.find_all do |item|
      item.description.include?(my_description)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item.unit_price.between?(range.begin, range.end)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def item_repo_goes_to_sales_engine_with_merchant_id(id)
    @parent.merch_repo_find_all_by_id(id)
  end
end
