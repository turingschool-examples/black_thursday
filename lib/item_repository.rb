require './lib/item'

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
      item.id.to_s == id.to_s
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.to_s.casecmp(name.to_s) == 0
    end
  end

  def find_all_with_description(phrase)
    items.find_all do |item|
      item.description.include?(phrase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == BigDecimal.new(price)
    end
  end

  def find_all_by_price_in_range(upper, lower)
    items.find_all do |item|
      above_lower_limit(lower, item) && below_upper_limit(upper, item)
    end
  end

  def above_lower_limit(lower, item)
    item.unit_price > BigDecimal.new(lower)
  end

  def below_upper_limit(upper, item)
    item.unit_price < BigDecimal.new(upper)
  end

  def find_all_by_merchant_id(id)
    items.find_all do |item|
      item.merchant_id == id.to_s
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end
end
