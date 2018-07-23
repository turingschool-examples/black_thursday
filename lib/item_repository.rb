class ItemRepository
  def initialize(items_file)
    @items = []
  end

  def create_items
    CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end
end
