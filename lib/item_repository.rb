class ItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    all.find { |item| id == item.id }
  end

  def find_by_name(name)
    all.find { |item| name.downcase == item.name.downcase }
  end

  def find_all_with_description(description)
    all.find_all { |item| description.downcase == item.description.downcase }
  end

  def find_all_by_price(price)
    all.find_all { |item| price == item.unit_price }
  end

  def find_all_by_price_in_range(range)
    all.find_all { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |item| merchant_id == item.merchant_id }
  end

  def create(attributes)
    new_id = all.max_by { |item| item.id }.id + 1
    attributes[:id] = new_id
    item = Item.new(attributes)
    all << item
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    item = find_by_id(id)
    all.delete(item)
  end

end
