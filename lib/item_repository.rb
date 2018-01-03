require 'csv'
require './lib/item.rb'

class ItemRepository
  attr_reader :items

  def initialize(path, sales_engine = "")
    @items = []
    item_creator_and_storer(path)
  end

  def csv_opener(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def item_creator_and_storer(path)
    csv_opener(path).each do |item|
      @items << Item.new(item, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    argument_raiser(id, Integer)
    @items.find {|item| item.id.to_i == id}
  end

  def find_by_name(name)
    argument_raiser(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(description)
    argument_raiser(description)
    @items.select {|item| item if item.description.downcase.include?(description.downcase)}
  end

  def find_all_by_price(price)
    argument_raiser(price, Integer)
    @items.select {|item| item if item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    argument_raiser(range, Range)
    @items.select {|item| item if range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    argument_raiser(merchant_id)
    @items.select {|item| item if item.merchant_id == merchant_id}
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

end
