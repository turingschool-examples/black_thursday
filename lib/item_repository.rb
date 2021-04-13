
class ItemRepository
  attr_reader :items
  def initialize(items = [])
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item_description = item.description.downcase
      item_description.include?(description.downcase)
    end
  end
end
