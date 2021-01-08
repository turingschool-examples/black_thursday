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
      item.unit_price == price
    end
  end
end
