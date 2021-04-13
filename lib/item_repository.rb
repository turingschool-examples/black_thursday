class ItemRepository

  def initialize

  end

  def create_items(parsed_data)
    @items_array = parsed_data.map do |item|
      Item.new(item)
   end
  end
end
