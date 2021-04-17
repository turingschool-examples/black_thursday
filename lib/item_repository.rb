require_relative 'sales_engine'
require_relative 'item'
require_relative 'mathable'

class ItemRepository
  include Mathable
  attr_reader :items

  def initialize(path, engine)
    @items = []
    @engine = engine
    make_items(path)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
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
      item.name.downcase == name.downcase
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

  def generate_new_id
    highest_id_item = @items.max_by do |item|
      item.id
    end
    new_id = highest_id_item.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @items << Item.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      item_to_update = find_by_id(id)
      variable_assigner(attributes, item_to_update)
      item_to_update.unit_price_to_big_decimal
      item_to_update.update_time_stamp
    end
  end

  def variable_assigner(attributes, item_to_update)
    attributes.each do |iv, new_value|
      if iv.to_s == 'name' || iv.to_s == 'description' || iv.to_s == 'unit_price'
        item_to_update.send("#{iv}=", new_value)
      end
    end
  end

  def delete(id)
    items.delete(find_by_id(id))
  end

  def items_per_merchant
    @items.each_with_object(Hash.new(0)) do |item, hash|
      hash[item.merchant_id] += 1
    end
  end

  def average_items_per_merchant
    average(items_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    hash = items_per_merchant
    hash.each_with_object([]) do |(merchant_id, number_of_items), array|
      if number_of_items > average(hash) + (standard_deviation(hash))
        array << @engine.find_merchant_by_id(merchant_id)
      end
    end
  end

  def average_item_price_for_merchant(merchant_id)
    hash = @items.each_with_object({}) do |item, hash|
      if item.merchant_id == merchant_id
        hash[item.id] = item.unit_price
      end
    end
    avg = (hash.values.sum / hash.keys.count).round(2)
  end
end
