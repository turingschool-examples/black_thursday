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

  def find_all_by_price
    []
  end

  def find_all_by_price_in_range
    []
    #will take argument of price with range and return those in that range.
  end

  def find_all_by_merchant_id
    []
  end

end
