class ItemRepository

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_by_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end 
end
