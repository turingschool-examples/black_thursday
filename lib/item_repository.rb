require 'csv'
require_relative 'item.rb'

class ItemRepository
  attr_reader :items

  def initialize(path, sales_engine = "")
    @items = {}
    item_creator_and_storer(path)
    @parent = sales_engine
  end

  def find_merchant_by_id(id)
    @parent.find_merchant_by_id(id)
  end

  def csv_opener(path = "./data/items.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def item_creator_and_storer(path)
    csv_opener(path).each do |item|
      new_item = Item.new(item, self)
      @items[new_item.id.to_i] = new_item
    end
  end

  def all
    @items.values
  end

  def find_by_id(id)
    argument_raiser(id, Integer)
    @items[id]
  end

  def find_by_name(name)
    argument_raiser(name)
    @items.find {|id, item| item.downcaser == name.downcase}[1]
  end

  def find_all_with_description(description)
    argument_raiser(description)
    @items.select {|id, item| item.description.downcase.include?(description.downcase)}.values
  end

  def find_all_by_price(price)
    argument_raiser(price, Integer)
    @items.select {|id, item| item.unit_price == price}.values
  end

  def find_all_by_price_in_range(range)
    argument_raiser(range, Range)
    @items.select {|id, item| range.include?(item.unit_price)}.values
  end

  def find_all_by_merchant_id(merchant_id)
    argument_raiser(merchant_id, Integer)
    @items.select {|id, item| item.merchant_id.to_i == merchant_id}.values
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

end
