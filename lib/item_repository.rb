require_relative './repository'
require_relative './item'

class ItemRepository < Repository

  def initialize
    @collection = {}
  end

  def add_item(item)
    @collection[item.id] = item
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_item(Item.new(attributes))
  end

  def find_all_by_price_in_range(range)
    all.select do |item|
      item.unit_price_to_dollars >= range.min && item.unit_price_to_dollars <= range.max
    end
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)
    return nil if item_to_update == nil
    item_to_update.name = attributes[:name] if attributes.has_key? (:name)
    item_to_update.description = attributes[:description] if attributes.has_key? (:description)
    item_to_update.unit_price = attributes[:unit_price] if attributes.has_key? (:unit_price)
    item_to_update.updated_at = Time.now
  end

  def find_all_by_merchant_id(id)
    all.select do |item|
      item.merchant_id == id
    end
  end

  def find_all_with_description(description)
    all.find_all do |collection|
      collection.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    all.find_all do |collection|
      collection.unit_price_to_dollars == price
    end
  end

end
