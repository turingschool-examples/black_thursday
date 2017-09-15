require_relative 'item'

class ItemRepository
  attr_reader :items, :sales_engine
  def initialize(item_file, sales_engine)
    @items = read_items_file(item_file)
    @sales_engine = sales_engine
  end

  def read_items_file(item_file)
    item_list =[]
    CSV.foreach(item_file, headers: true, header_converters: :symbol) do |row|
      item_info = {}
      item_info[:id] = row[:id]
      item_info[:name] = row[:name]
      item_info[:description] = row[:description]
      item_info[:unit_price] = row[:unit_price]
      item_info[:created_at] =row[:created_at]
      item_info[:updated_at] = row[:updated_at]
      item_info[:merchant_id] = row[:merchant_id]
      item_list << Item.new(item_info, self)
    end
    item_list
  end

  def all
    items
  end

  def find_by_id(id)
    items.find {|item| item.id == id}
  end

  def find_by_name(name)
    items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(word)
    items.find_all {|item| item.description.downcase.include?(word.downcase)}
  end

  def find_all_by_price(price)
    items.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    items.find_all {|item| range.cover?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all {|item| item.merchant_id == merchant_id}
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
