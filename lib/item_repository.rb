require_relative './item'

class ItemRepository
  attr_reader :items,
              :parent

  def initialize(items, parent)
    @items = items.map {|item| Item.new(item, self)}
    @parent = parent
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(phrase)
    items.find_all do |item|
      item.description.downcase.include?(phrase.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    items.find_all do |item|
      item.merchant_id.to_s == id.to_s
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
