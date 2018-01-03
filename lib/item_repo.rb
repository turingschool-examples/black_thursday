require_relative "sales_engine"
require_relative "item"

class ItemRepo
  attr_reader :items,
              :parent

  def initialize(parent, filename)
    @items        = []
    @sales_engine = parent
    load_items(filename)
  end

  def load_items(filename)
    items_csv = CSV.open filename,
                          headers: true,
                          header_converters: :symbol,
                          converters: :numeric
    items_csv.each do |row| @items << Item.new(row, self)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    items.find_all do |item|
      items.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all { |item| items.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    items.find_all { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id }
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end
end
