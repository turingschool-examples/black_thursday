require 'time'
require_relative '../lib/item'
require 'csv'
require_relative './find_methods'
class ItemRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end

  def find_all_with_description(description)
    description_case = description.downcase
    @collection.find_all do |item|
      item.description.downcase.include?(description_case)
    end
  end

  def find_all_by_price(price)
    @collection.find_all do |item|
      item.unit_price == price.to_i
    end
  end

  def find_all_by_price_in_range(range)
    @collection.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(id)
    @collection.find_all do |item|
      item.merchant_id == id
    end
  end

  def create(attributes)
    highest = @collection.max_by do |item|
      item.id.to_i
    end
    number = highest.id.to_i + 1
    new_item = Item.new({ id: number,
                  name: attributes[:name],
                  description: attributes[:description].to_s,
                  unit_price: big_decimal_converter(attributes[:unit_price]),
                  merchant_id: attributes[:merchant_id].to_i,
                  created_at: Time.now.to_s,
                  updated_at: Time.now.to_s
                  })
    @collection << new_item
    new_item
  end

  def update(id, attributes)
    if find_by_id(id)
    if attributes.has_key?(:name)
      find_by_id(id).name = attributes[:name]
    end
    if attributes.has_key?(:description)
      find_by_id(id).description = attributes[:description]
    end
    if attributes.has_key?(:unit_price)
      find_by_id(id).unit_price = attributes[:unit_price]
    end
    find_by_id(id).updated_at = Time.now
    end
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    number = price.to_f
    BigDecimal.new(number, significant_digits)
  end
end
