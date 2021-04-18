require_relative './items'
require 'time'
require 'csv'
require 'bigdecimal'

class ItemRepo
  attr_reader :item_list

  def initialize(csv_files, engine)
    @item_list = item_instances(csv_files)
    @engine    = engine
  end

  def find_merchants_by_id(id)
    @engine.find_merchants_by_id(id)
  end

  def item_instances(csv_files)
    items = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @item_list = items.map do |item|
      Item.new(item, self)
    end
  end

  def all
    @item_list
  end

  def find_by_id(id)
    @item_list.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @item_list.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @item_list.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @item_list.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @item_list.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @item_list.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_item = Item.new(attributes, self)
    # refactor potential helper method
    find_max_id = @item_list.max_by do |item|
      item.id
    end
    new_item.id = (find_max_id.id + 1)
    item_list << new_item
  end

  def item_exists?(id)
    item = find_by_id(id)
    item != nil
  end

  def unit_price_exists?(attributes)
    attributes[:unit_price] != nil
  end

  def update(id, attributes)
    item = find_by_id(id)
    if !item.nil?
      item.name = attributes[:name] unless attributes[:name].nil?
      item.description = attributes[:description] unless attributes[:description].nil?
      item.unit_price = BigDecimal(attributes[:unit_price], 5) unless attributes[:unit_price].nil?
      item.updated_at = Time.now
    end
    item
  end

  def delete(id)
    item = find_by_id(id)
    if item_exists?(id)
      @item_list.delete(item)
    end
  end
end
