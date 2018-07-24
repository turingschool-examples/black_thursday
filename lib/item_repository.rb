require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'

class ItemRepository
  def initialize(items)
    @items = items
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
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    if price.class != BigDecimal
      price = (price / 100.00).to_s.to_d
    end
    @items.find_all do |item|
      item.unit_price == price
      binding.pry
    end

  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price.to_f * 100)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    highest_item_id = @items.max_by do |item|
      item.id
    end
    attributes[:id] = highest_item_id.id + 1
    @items << Item.new(attributes)
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

  def delete(id)
    @items.reject! do |item|
      item.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
