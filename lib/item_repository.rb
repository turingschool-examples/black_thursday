require_relative "item"
require "csv"

class ItemRepository
  attr_reader :items

  def initialize(item_file)
    @items = items_from_csv(item_file)
  end

  def items_from_csv(item_file)
    item_list = []
    CSV.foreach(item_file, headers: true, header_converters: :symbol) do |row|
      item_info = {}
      item_info[:id] = row[:id]
      item_info[:name] = row[:name]
      item_info[:description] = row[:description]
      item_info[:unit_price] = row[:unit_price]
      item_info[:merchant_id] = row[:merchant_id]
      item_info[:created_at] = row[:created_at]
      item_info[:updated_at] = row[:updated_at]
      item_list << Item.new(item_info)
    end
    item_list
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(word)
    @items.find_all do |item|
      item.description.downcase.include?(word.downcase)
    end
    # @items.find_all {|item| item.description.include?(word)}
  end

  def find_all_by_price(unit_price)
    @items.find_all {|item| item.unit_price == unit_price}
  end

  def find_all_by_price_in_range(range)
    #Not sure hwo to get pull within a range... any ideas?
    #http://ruby-doc.org/core-1.9.3/Range.html#method-i-cover-3F
    @items.find_all {|item| range.cover?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all {|item| item.merchant_id == merchant_id}
  end

  def inspect
    "#{self.class} #{items.size} rows"
  end
end
