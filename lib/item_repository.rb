require_relative 'item'

class ItemRepository
  def initialize(item_data)
    @item_rows ||= build_item(item_data)
    @items = @item_rows
  end

  def build_item(item_data)
    item_data.map do |item|
      Item.new(item)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.casecmp(name).zero?
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
    @items.max_by do |item|
      item.id
    end
  end

  def create_id
    find_highest_id.id + 1
  end

  def create(attributes)
    id = create_id
    attributes[:id] = id
    item = Item.new(attributes)
    @items << item
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name]
    item.description = attributes[:description]
    item.unit_price = attributes[:unit_price]
    item.updated_at = Time.now
  end

  def delete(id)
    item = @items.find_index do |item|
      item.id == id
    end
    @items.delete_at(item)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
