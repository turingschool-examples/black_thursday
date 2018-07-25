require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'
require_relative 'repository'

class ItemRepository
  include Repository

  def initialize(items)
    @list = items
  end

  def find_all_with_description(description)
    @list.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    if price.class != BigDecimal
      price = (price.to_f / 100).to_s.to_d
    end
    @list.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @list.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def create(attributes)
    highest_item_id = find_highest_id
    attributes[:id] = highest_item_id.id + 1
    @list << Item.new(attributes)
  end

  def update(id, attributes)
    if find_by_id(id)
      if attributes.key?(:name)
        find_by_id(id).name = attributes[:name]
      end
      if attributes.key?(:description)
        find_by_id(id).description = attributes[:description]
      end
      if attributes.key?(:unit_price)
        find_by_id(id).unit_price = attributes[:unit_price]
      end
      find_by_id(id).updated_at = Time.now
    end
  end
end
