# item_repository
class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
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
    @items.find_all { |item| item.description.downcase == description.downcase }
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price.to_i == price }
  end

end
