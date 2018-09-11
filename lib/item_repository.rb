require_relative 'item'

class ItemRepository

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def all
    items
  end

  def find_by_id(id)
    items.find {|item| item.id == id}
  end

  def find_by_name(name)
    items.find {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(description)
    items.find_all {|item| (item.description.include? description) == true }
  end

  def find_all_by_price(price)
    items.find_all {|item| item.unit_price_to_dollars == price.to_f}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_price_in_range(range)
    items.find_all {|item| range.include?(item.unit_price_to_dollars)}
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(attributes)
    max_id = (items.max_by{|item| item.id}).id + 1
    attributes[:id] = max_id
    new_item = Item.new(attributes)
    add_item(new_item)
    new_item
  end

  def update(id, attributes)
    if find_by_id(id) == nil

    else
      item = find_by_id(id)
      item.name = attributes[:name]
      item.description = attributes[:description]
      item.unit_price = attributes[:unit_price]
      item.updated_at = Time.new
      item
    end
  end

  def delete(id)
    if find_by_id(id) == nil

    else
    index = items.find_index {|i| i.id == id}
    items.delete_at(index)
    end
  end
end
