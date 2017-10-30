require_relative "item"
require "csv"

class ItemRepository
  attr_reader :items

  def initialize(file)
    @items = from_csv(file)
  end

  def from_csv(file)
    item_list = []
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
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

  def find_by_id
    @items.find {|item| item.id}
  end

end
