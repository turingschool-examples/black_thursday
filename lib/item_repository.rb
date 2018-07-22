require 'csv'
require_relative '../lib/item.rb'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(item_location)
    @item_location = item_location
    @items = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@item_location, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    @items.find do |item|
      item.id == id_number.to_s
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    downcased_description = description.downcase
    @items.find_all do |item|
      item.description.downcase.include?(downcased_description)
    end
  end

  def find_all_by_price(price)
    price_string = price.to_s
    @items.find_all do |item|
      item.unit_price.include?(price_string)
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_id_string = merchant_id.to_s
    @items.find_all do |item|
      item.merchant_id.include?(merchant_id_string)
    end
  end

  def create(item_name, item_description, unit_price, merchant_id)
    @items << Item.new({name: item_name, description: item_description, id: create_id, unit_price: unit_price, created_at: Time.now, updated_at: Time.now, merchant_id: merchant_id})
  end

  def create_id
    sorted_items = @items.sort_by do |item|
      item.id
    end
    last_item = sorted_items.last
    (last_item.id.to_i + 1).to_s
  end

  def update(id, new_name, new_description, new_unit_price)
    find_by_id(id).name = new_name
    find_by_id(id).description = new_description
    find_by_id(id).unit_price = new_unit_price
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.ItemRepository} #{@items.size} rows>"
  end
end
