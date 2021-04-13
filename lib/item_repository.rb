class ItemRepository

  def initialize(parsed_data)
    create_items(parsed_data)
  end

  def create_items(parsed_data)
    @items_array = parsed_data.map do |item|
      Item.new(item)
   end
  end
end
