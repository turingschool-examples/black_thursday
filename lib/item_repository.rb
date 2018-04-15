require_relative '../lib/item'
require_relative 'repository'

# item repo class
class ItemRepository < Repository
  attr_reader :items

  def initialize(items_data)
    # attributes = csv_parsed_array.map do |item|
    #   { id: item[0].to_i,
    #     name: item[1],
    #     description: item[2],
    #     unit_price: item[3],
    #     merchant_id: item[4],
    #     created_at: Time.parse(item[5]),
    #     updated_at: Time.parse(item[6]) }
    # end
    @items = create_index(Item, items_data)
    super(items, Item)
  end

  def find_all_with_description(fragment)
    @items.values.find_all do |item|
      item.description.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price(price)
    @items.values.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.values.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.values.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def update(id, attrs)
    return unless @items[id]
    @items[id].name = attrs[:name] if attrs[:name]
    @items[id].description = attrs[:description] if attrs[:description]
    @items[id].unit_price = attrs[:unit_price] if attrs[:unit_price]
    @items[id].updated_at = Time.now
  end
end
