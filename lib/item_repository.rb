class ItemRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_items(item)
    all <<(item)
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name == name
    end
  end

  def find_all_with_descriptions(description_inc)
    all.find_all do |item|
      item.description.include?(description_inc)
    end
  end

  def find_by_price(unit_price)
    all.find do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(price_range)
    all.find_all do |item|
      price_range.include?(item.unit_price_to_float)
    end
  end

  def find_all_by_merchant_id
    []
  end

end
