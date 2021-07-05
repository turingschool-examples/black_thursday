require 'CSV'

class ItemRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents[row[:id]] = Item.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    @contents.each do |_, item|
      return item if name.downcase == item.name.downcase
    end
    nil
  end

  def find_all_with_description(description)
    items = []
    @contents.each do |_, item|
      items << item if item.description == description
    end
    items
  end

  def find_all_by_price(price)
    items = []
    @contents.each do |_, item|
    items << item if item.unit_price == price.to_i
    end
    items
  end

  def find_all_by_price_in_range(range)
    @contents.find do |item|
    true if range.include?(item[1].unit_price.to_f)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
