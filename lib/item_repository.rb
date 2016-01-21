require          'csv'
require          'pry'
require          'bigdecimal'
require_relative 'item'

class ItemRepository
  attr_reader   :all, :items

  def initialize(csv_hash)
    @items ||= csv_hash.map {|csv_hash| Item.new(csv_hash)}
  end

  def all
    items
  end

  def standard(standardized_data)
    standardized_data.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(item_id)
    items.find { |item| item.id.to_i == item_id.to_i}
  end

  def find_by_name(item_name)
    items.find { |item| item.name.to_s.downcase == item_name.downcase}
  end

  def find_all_with_description(description)
    items.find_all { |item| item.description.downcase.include?(description.downcase)}
  end

  def find_all_by_price(input_price)
    items.find_all { |item| item.unit_price.to_f == input_price.to_f }
  end

  def find_all_by_price_in_range(range_input)
    range = (range_input).to_a

    items.find_all {|item| range_input.include?(item.unit_price.to_f)}
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id == merchant_id.to_i}
  end

  def most_sold_item(merchant_id)
    items = find_all_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def item_unit_price
    all.reduce(0) {|sum, item|
       sum + item.unit_price}
  end

  def number_of_items
    all.count
  end

  def average_prices_of_all_items
    item_unit_price / number_of_items
  end

  def sum_deviations_from_the_mean
    all.inject(0) { |accum, items|
      accum + (items.unit_price - average_prices_of_all_items) ** 2 }
  end

  def variance
    sum_deviations_from_the_mean / (number_of_items - 1)
  end
  
end
