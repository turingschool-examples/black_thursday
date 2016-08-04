require_relative 'item'

class ItemRepository
  attr_reader :items, :parent

  def initialize(item_contents, parent = nil)
    @items = make_items(item_contents)
    @parent = parent
  end

  def make_items(item_contents)
    item_contents.map { |row| Item.new(row, self) }
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.upcase == name.upcase }
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.upcase.include? description.upcase
    end
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all { |item| range.include? item.unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
