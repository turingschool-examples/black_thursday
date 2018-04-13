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
      items << item  if item.description == description
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
    items = []
    @contents.each do |_, item|
      items << item if range.include?(item.unit_price.to_f)
    end
    items
  end

  def find_all_by_merchant_id(merchant_id)
    items = []
    @contents.each do |_, item|
      items << item if item.merchant_id == merchant_id
    end
    items
  end


  def create(attributes)
    max_id = @contents.max_by do |key, item|
      key
    end
      max = max_id[0].to_i + 1
      attributes[:id] = max
      @contents[:max] = Item.new(attributes, self)
  end

  def update(id, attributes)
    @contents[id] = attributes
  end

  def delete(id)
    @contents.delete(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
