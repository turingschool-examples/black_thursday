class ItemRepository
  def initialize(list)
    @list = list
  end

  def all
    @list
  end

  def find_by_id(num)
    @list.find {|item| item.id == num}
  end

  def find_by_name(name)
    @list.find {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(description)
    @list.select {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    @list.select {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_range(range)
    @list.select {|item| range.include?(item.unit_price_to_dollars)}
  end
end