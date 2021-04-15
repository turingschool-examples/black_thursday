require_relative '../lib/item'
class ItemRepository

  def initialize(parsed_data)
    create_items(parsed_data)
  end
  #add so spec harness would run successfully.
  def inspect
  "#<#{self.class} #{@items_array.size} rows>"
  end

  def create_items(parsed_data)
    @items_array = parsed_data.map do |item|
      Item.new(item)
   end
  end

  def all
    @items_array
  end

  def find_by_id(id)
    @items_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items_array.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @items_array.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items_array.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items_array.find_all do |item|
      item.unit_price_to_dollars <= range.max && item.unit_price_to_dollars >= range.min
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_item = Item.new(attributes)
    max_id = @items_array.max_by do |item|
      item.id
    end.id
    new_item.id = max_id + 1
    @items_array << new_item
  end

  def update(id, attributes)
    target = find_by_id(id)
    target.name = attributes[:name]
    target.description = attributes[:description]
    target.unit_price = attributes[:unit_price]
    target.updated_at = Time.now
  end

  def delete(id)
    target = find_by_id(id)
    @items_array.delete(target)
  end

end
