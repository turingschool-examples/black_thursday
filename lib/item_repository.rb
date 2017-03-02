require_relative 'item'
require_relative 'merchant'
class ItemRepository
  attr_reader :items, :sales_engine
  def initialize (items, sales_engine = nil)
    @items = items
    @sales_engine = sales_engine
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |row| row.id == id }
  end

  def find_by_name(item_name)
    items.find { |row| row.name.downcase == item_name.downcase }
  end

  def find_all_with_description(item_description)
    items.select do |row|
      row.description.downcase.include? (item_description.downcase)
    end
  end

  def find_all_by_price(item_price)
    items.select { |row| row.unit_price == item_price }
  end

  def find_all_by_price_in_range(range)
    items.select do |row|
      row.unit_price >= range.first && row.unit_price <= range.last
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |row| row.merchant_id == merchant_id }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
