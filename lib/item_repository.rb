require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :items

  def initialize(path)
    @items = []
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data)
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

  def find_all_by_price_in_range(price_range)
    @items.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def create_new_id
    @items.map do |item|
      item.id
    end.max + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.utc
    attributes[:updated_at] = Time.now.utc
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    find_by_id(id).updated_at = Time.now.utc
    find_by_id(id).name = attributes[:name]
    find_by_id(id).description = attributes[:description]
    find_by_id(id).unit_price = attributes[:unit_price]
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end
  
  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
 end
end
