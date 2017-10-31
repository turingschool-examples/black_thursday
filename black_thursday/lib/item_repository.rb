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

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name.to_s.downcase == name.to_s.downcase}
  end

  def find_all_with_description(description)
    return [] if description.nil?
    items.find_all do |item|
      item.description.to_s.downcase.index(description.downcase)
    end
  end

  def find_all_by_price(price)
    return [] if price.nil?
    items.find_all do |item|
      item.unit_price == price
    end
  end
end
