class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      #if the ids match
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.upcase == description.upcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      #the range includes the unit price
      range.include?(item.unit_price)
    end
  end
end