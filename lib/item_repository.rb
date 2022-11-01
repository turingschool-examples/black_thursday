class ItemRepository


  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description)
    items_with_description = @items.find_all {|item| item.description.upcase == description.upcase}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    price = range.to_a
    min = price.min
    max = price.max
    @items.find_all {|item|
      item.unit_price_to_dollars >= min && item.unit_price_to_dollars <= max}
  end

  def find_all_by_merchant_id(merch_id)
    @items.find_all {|item| item.merchant_id == merch_id}
  end
  
  def create(attributes)
    ids = @items.map { |item| item.id}
    attributes[:id] = ids.max + 1
    new_item = Item.new(attributes)
    @items.push(new_item)
    new_item
  end
  
  def update(id, attributes)
    updated_item = find_by_id(attributes[:id])
    updated_item.update_name(attributes[:name])
    updated_item.update_description(attributes[:description])
    updated_item.update_unit_price(attributes[:unit_price])
    updated_item
  end
  
  def delete(id)
    @items.delete(find_by_id(id))
  end

end
