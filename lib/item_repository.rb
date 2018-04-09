require_relative '../lib/item'

# item repo class
class ItemRepository
  attr_reader :items

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |item|
      { id: item[0].to_i,
        name: item[1],
        description: item[2],
        unit_price: item[3],
        merchant_id: item[4],
        created_at: item[5],
        updated_at: item[6] }
    end
    @items = create_index(attributes)
  end

  def create_index(attributes)
    item_data = {}

    attributes.each do |attribute_set|
      item_data[attribute_set[:id]] = Item.new(attribute_set)
    end
    item_data
  end

  def all
    @items.values
  end

  def find_by_id(id)
    @items[id]
  end

  def find_by_name(name)
    result = nil
    @items.values.each do |item|
      result = item if item.name.casecmp(name).zero?
    end
    result
  end

  def find_all_by_name(fragment)
    @items.values.map do |item|
      item if item.name.downcase.include?(fragment.downcase)
    end.compact
  end

  def find_all_with_description(fragment)
    @items.values.map do |item|
      item if item.description.downcase.include?(fragment.downcase)
    end.compact
  end

  def find_all_by_price(price)
    @items.values.map do |item|
      item if item.unit_price == price
    end.compact
  end

  def find_all_by_price_in_range(range)
    @items.values.map do |item|
      item if range.include?(item.unit_price)
    end.compact
  end

  def find_all_by_merchant_id(merchant_id)
    @items.values.map do |item|
      item if item.merchant_id == merchant_id
    end.compact
  end

  def create_new_id
    highest_id = @items.keys.max
    (highest_id.to_i + 1)
  end

  def create(attributes)
    attributes[:id] = create_new_id
    @items[attributes[:id]] = Item.new(attributes)
  end

  def update(id, attributes)
    @items[id].name = attributes[:name] if attributes[:name]
    @items[id].description = attributes[:description] if attributes[:description]
    @items[id].unit_price = attributes[:unit_price] if attributes[:unit_price]
    @items[id].updated_at = Time.now
  end

  def delete(id)
    @items.delete(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
