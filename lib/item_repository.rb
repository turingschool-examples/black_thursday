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
      if items_with_description == nil
        []
      else
        items_with_description
      end
  end


end
