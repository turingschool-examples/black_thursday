class ItemRepository
  def initialize(item_data)
    @item_rows ||= build_item(item_data)
    @items = @item_rows
  end

  def build_item(item_data)
    item_data.map do |item|
      Item.new(item)
    end
  end
end
