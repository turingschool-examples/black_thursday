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
      @items[new_item.id] = new_item
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
    all.find {|item| item.downcaser == name.downcase}
  end

  def find_all_with_description(description)
    argument_raiser(description)
    all.select {|item| item.description.downcase.include?(description.downcase)}
  end

  def find_all_by_price(price)
    argument_raiser(price, BigDecimal)
    all.select {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    argument_raiser(range, Range)
    all.select {|item| range.include?(item.unit_price_to_dollars)}
  end

  def find_all_by_merchant_id(merchant_id)
    argument_raiser(merchant_id, Integer)
    all.select {|item| item.merchant_id == merchant_id}
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class 
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
