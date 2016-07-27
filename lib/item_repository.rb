require 'pry'
require 'bigdecimal'
require './lib/item'

class ItemRepository
  attr_reader :items

  def initialize(item_contents)
    @items = make_items(item_contents)
  end

  def make_items(item_contents)
    item_contents.map { |row| make_item(row) }
  end

  def make_item(row)
    data = make_prepared_data(row)
    Item.new(data)
  end

  def make_prepared_data(row)
    {
      id:           row[:id].to_i,
      name:         row[:name],
      description:  row[:description],
      unit_price:   prepare_unit_price(row[:unit_price]),
      merchant_id:  row[:merchant_id].to_i,
      created_at:   prepare_time(row[:created_at]),
      updated_at:   prepare_time(row[:updated_at])
    }
  end

  def prepare_unit_price(unit_price)
    digits = unit_price.to_s.length - 1
    BigDecimal.new(unit_price, digits)
  end

  def prepare_time(time)
    Time.parse(time)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.upcase == name.upcase }
  end

  def find_all_with_description(description_excerpt)
    @items.find_all { |item| item.description.upcase.include? description_excerpt.upcase }
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all { |item| range.include? item.unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all { |item| item.merchant_id == merchant_id }
  end

end
