require_relative "item"
require "csv"

class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(item_file, sales_engine)
    @items = []
    items_from_csv(item_file)
    @sales_engine = sales_engine
  end

  def items_from_csv(item_file)
    CSV.foreach(item_file, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(word)
    @items.find_all do |item|
      item.description.downcase.include?(word.downcase)
    end
  end

  def find_all_by_price(unit_price)
    @items.find_all {|item| item.unit_price == unit_price}
  end

  def find_all_by_price_in_range(range)
    @items.find_all {|item| range.cover?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all {|item| item.merchant_id == merchant_id}
  end

  def item_merchant(merchant_id)
    sales_engine.find_item_merchant(merchant_id)
  end

  def inspect
    "#{self.class} #{items.size} rows"
  end
end
