require 'CSV'
require 'pry'
require_relative './item'

class ItemRepository
 attr_reader :items

  def initialize(item_path)
    @items = []
    make_items(item_path)
  end

  def all
    @items
  end

  def make_items(item_path)
    CSV.foreach(item_path, headers: true, header_converters: :symbol) do |row|
     @items << Item.new(row)
    end
  end

  def find_by_id(id)
    @items.find do |item|
     item.id == id
    end
  end

  def find_by_name(name)
   @items.find do |item|
     item.name == name
    end
  end

  def find_all_with_description(item_description)
    @items.find_all do |item|
     item.description.include?(item_description)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
     item.unit_price == price
    end
  end


  def find_all_by_price_in_range(range)
    @items.find_all do |item|
     range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
     item.merchant_id == id
    end
  end

  def find_max_item_id
    max_item = @items.max_by do |item_num|
      item_num.id
    end
    max_item
  end

  def create(attributes)
    attributes[:id] = find_max_item_id.id + 1
      new_item = Item.new(attributes)
      @items << new_item
    new_item
  end

  def update(id, attributes)
    @items.find do |item|
      if item.id == id
      updated_nam = attributes[:name]
      updated_description = attributes[:description]
      updated_unit_price = attributes[:unit_price]
      # item.updated_at = Time.now
      end
    end
  end

end
