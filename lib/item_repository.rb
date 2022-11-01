class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      #if the ids match
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.upcase == description.upcase
    end
  end
end