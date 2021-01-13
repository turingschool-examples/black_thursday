require_relative 'item'
require_relative 'sales_engine'
require_relative 'mathable'
class ItemRepository
  include Mathable
  attr_reader :path,
              :items,
              :engine

  def initialize(path, engine)
    @path = path
    @items = []
    @engine = engine
    read_item
  end

  def read_item
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
    @items
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
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
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def highest_id
    @items.max do |item|
      item.id
    end
  end

  def create(attributes, item_repo = item_repo)
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.new.to_s
    attributes[:id] = highest_id.id + 1
    @items.insert(2, Item.new(attributes, self))
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?

    update.name = attributes[:name] if attributes.has_key?(:name)
    update.description = attributes[:description] if attributes.has_key?(:description)
    update.unit_price = attributes[:unit_price] if attributes.has_key?(:unit_price)
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @items.delete(delete)
  end

  def merchant_item_count
    @items.each_with_object({}) do |item, acc|
      merchant_item_count = find_all_by_merchant_id(item.merchant_id).length
      acc[item.merchant_id] = merchant_item_count
    end
  end

  def average_item_price
    price_total = @items.sum do |item|
      item.unit_price_to_dollars
    end
    average_stuff(price_total, @engine.count_items)
  end

  def merchant_id_list
    merchant_id_list = []
    @items.each do |item|
      merchant_id_list << item.merchant_id
    end
    merchant_id_list.uniq
  end

  def items_sum
    @items.sum do |item|
      item.unit_price_to_dollars
    end
  end

  def total_items
    @items.count
  end
end
