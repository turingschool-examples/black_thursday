require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all,
              :sales_engine

  def initialize(file, sales_engine)
    @all = []
    @sales_engine = sales_engine
    populate_item_repo(file)
  end

  def populate_item_repo(file)
    item_lines = CSV.open(file, headers: true, header_converters: :symbol)
    item_lines.each do |row|
      item = Item.new(row, self)
      all << item
    end
    item_lines.close
  end

  def add_items(item)
    all <<(item)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(unit_price)
    all.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(price_range)
    all.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |id|
      id.merchant_id == merch_id
    end
  end

  def sales_engine_merchant_id(merchant_id)
    find_all_by_merchant_id(merchant_id)
  end

  def merchant(item_id)
    @sales_engine.merchant(item_id)
  end

  def items
    @items
  end
end
