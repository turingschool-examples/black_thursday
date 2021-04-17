# require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/repository'
require 'bigdecimal/util'

class ItemRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_items(@parsed_csv_data)
  end

  def create_items(parsed_csv_data)
    parsed_csv_data.map do |item|
      Item.new(item)
    end
  end

  def inspect
  "#<#{self.class} #{@array_of_objects.size} rows>"
  end

  def find_by_name(name)
    @array_of_objects.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @array_of_objects.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @array_of_objects.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @array_of_objects.find_all do |item|
      item.unit_price_to_dollars <= range.max && item.unit_price_to_dollars >= range.min
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @array_of_objects.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    max_id = @array_of_objects.max_by do |item|
      item.id
    end.id
    new_item = Item.new(attributes)
    new_item.id = max_id + 1
    @array_of_objects << new_item
  end

  def update(id, attributes)
    target = find_by_id(id)
    target.name = attributes[:name]
    target.description = attributes[:description]
    target.unit_price = attributes[:unit_price]
    target.updated_at = Time.now
  end

end
