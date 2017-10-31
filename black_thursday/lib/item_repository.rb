class ItemRepository
  attr_reader :items

  def initialize(items, parent = "")
    @items  = load_csv(items).map { |row| Item.new(row, self) }
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @items
  end
end
