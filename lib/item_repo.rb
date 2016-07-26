require 'csv'
require './lib/item'
class ItemRepo

  attr_reader :items

  def initialize(source_file)
    contents = CSV.open source_file, headers: true, header_converters: :symbol
    @items = contents.map do |row|
      Item.new(row)
    end
  end

  def find_by_id(item_id)
    @items.detect do |item|
      item.id == item_id
    end
  end

  def find_by_name(item_name)
    @items.detect do |item|
      item.name.upcase == item_name.upcase
    end
  end

  def find_all_by_description(description)
    @items.select do |item|
      item.description.upcase.include?(description.upcase)
    end
  end

  def find_all_by_price(price)
    @items.select do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @items.select do |item|
      item.unit_price_to_dollars <= price_range.max &&
      item.unit_price_to_dollars >= price_range.min
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.select do |item|
      item.merchant_id == merchant_id
    end
  end
end
