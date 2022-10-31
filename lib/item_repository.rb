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
end
