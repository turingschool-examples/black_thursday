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

  def find_by_name(_name)
    @items.find { |name| item.name.downcase == name.downcase }
  end
end
