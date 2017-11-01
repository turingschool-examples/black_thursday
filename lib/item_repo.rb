require "./lib/sales_engine"
require "./lib/item"
require "csv"

class ItemRepository
  attr_reader :items,
              :sales_engine


  def initialize(parent, filename)
    @items         = []
    @sales_engine  = parent
    @load          = load_items(filename)
  end

  def load_items(filename)
    items_csv = CSV.open filename,
                          headers: true,
                          header_converters: :symbol

    items_csv.each { |item| @items << Item.new(item, self) }
  end

  def count
    items.count
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    @items.find_all { |item| item.description.downcase.include?(description.downcase) }
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price.to_f/100 == price }
  end

  def find_all_by_price_in_range(price_range)
    @items.find_all { |item| price_range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_merchant(merchant_id)
    @sales_engine.find_merchant(merchant_id)
  end
end
