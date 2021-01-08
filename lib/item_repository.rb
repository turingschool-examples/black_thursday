require_relative 'item'
require_relative 'sales_engine'
class ItemRepository
  attr_reader:path,
             :items
  def initialize(path)
    @path = path
    @items = []
    read_item
  end

  def read_item
    CSV.foreach(@path, headers: :true , header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
    return @items
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
      item.unit_price_to_dollars ==  price
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

  def create(attributes)
    attributes[:id] = highest_id.id + 1
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    if find_by_id(id)
      if attributes.has_key?(:name)
      end
    end
  end
end
