class ItemRepository

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description)
    items_with_description = @items.find_all {|item| item.description.upcase == description.upcase}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    price = range.to_a
    min = price.min
    max = price.max
    @items.find_all {|item|
      item.unit_price_to_dollars >= min && item.unit_price_to_dollars <= max}
  end
end
