require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :items

  def initialize(path, sales_engine = "")
    @items = {}
    @parent = sales_engine
    item_creator_and_storer(path)
  end

  def item_creator_and_storer(path)
    csv_opener(path).each do |item|
      new_item = Item.new(item, self)
      @items[new_item.id] = new_item
    end
  end

  def csv_opener(path = "./data/items.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def find_merchant_by_id(id)
    argument_raiser(id)
    @parent.find_merchant_by_id(id)
  end

  def all
    @items.values
  end

  def find_by_id(id)
    argument_raiser(id)
    @items[id]
  end

  def find_by_name(name)
    argument_raiser(name, String)
    all.find do |item|
      item.downcaser == name.downcase
    end
  end

  def find_all_with_description(description)
    argument_raiser(description, String)
    all.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    argument_raiser(price, BigDecimal)
    all.select do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    argument_raiser(range, Range)
    all.select do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    argument_raiser(merchant_id)
    all.select do |item|
      item.merchant_id == merchant_id
    end
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
