class ItemRepository

  def initialize(items)
    @items = items
  end


  def all
    @items.dup
  end

  def find_by_id(id)
    @items.find{ |item| item.id == id }
  end

  def find_by_name(name)
    @items.find{ |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(substring)
    @items.find_all{ |item| item.description.downcase.include? substring.downcase }
  end

  def find_all_by_price(unit_price)
    @items.find_all{ |item| item.unit_price == unit_price }
  end

  def find_all_by_price_in_range(unit_price_range)
    @items.find_all{ |item| unit_price_range.include? item.unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all{ |item| item.merchant_id == merchant_id }
  end

end
