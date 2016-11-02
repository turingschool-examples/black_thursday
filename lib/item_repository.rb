require_relative 'item'

class ItemRepository

  attr_reader :all

  def initialize(items)
    @all = items
  end

  def find_by_id(id)
    all.find {|item| item.id == id}
  end

  def find_by_name(name)
    all.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.upcase.include?(description.upcase)
    end
  end

  def find_all_by_price(unit_price)
    all.find_all {|item| item.unit_price == unit_price}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_price_in_range(price_range)
    all.find_all {|item| price_range.include?(item.unit_price)}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end