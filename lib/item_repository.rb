class ItemRepository

  def initialize(parsed_data)
    create_items(parsed_data)
  end

  def create_items(parsed_data)
    @items_array = parsed_data.map do |item|
      Item.new(item)
   end
  end

  def all
    @items_array
  end

  def find_by_id(id)
    @items_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items_array.find do |item|
      item.name.downcase == name.downcase
    end
  end
end
