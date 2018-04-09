require_relative '../lib/item'
require_relative 'repository'

# item repo class
class ItemRepository < Repository
  attr_reader :items

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |item|
      { id: item[0].to_i,
        name: item[1],
        description: item[2],
        unit_price: item[3],
        merchant_id: item[4],
        created_at: Time.parse(item[5]),
        updated_at: Time.parse(item[6]) }
    end
    @items = create_index(Item, attributes)
    super(items, Item)
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

  def update(id, attributes)
    if @items[id]
      @items[id].name = attributes[:name] if attributes[:name]
      @items[id].description = attributes[:description] if attributes[:description]
      @items[id].unit_price = attributes[:unit_price] if attributes[:unit_price]
      @items[id].updated_at = Time.now
    end
  end
end
