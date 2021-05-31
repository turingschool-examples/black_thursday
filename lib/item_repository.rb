class ItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    all.find { |item| id == item.id }
  end

  def find_by_name(name)
    all.find { |item| name == item.name }
  end

  def find_all_with_description(description)
    all.find_all { |item| description == item.description }
  end

  def find_all_by_price(price)
    all.find_all { |item| price == item.unit_price }
  end

end
