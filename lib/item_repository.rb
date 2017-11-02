require './lib/item'
require 'bigdecimal'
require 'bigdecimal/util'


class ItemRepository
  attr_reader :items,
              :find_all_by_description,
              :find_all_by_price_in_range

  def initialize(parent)
    @items = []
    @sales_engine = parent
  end

  def create_item(data)
     CSV.foreach data, headers: true, header_converters: :symbol do |row|
      @items << Item.new(row, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find{|item| item.id == id.to_s}
  end

  def find_by_name(name)
   @items.find{|item| name if item.name == name}
  end

  def find_all_by_description(description)
   @items.find_all{|item| item.description == description}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price == price.to_d}
  end

  def find_all_by_price_in_range(low_price, high_price)
    items = @items.find_all do |item|
      item.unit_price > low_price && item.unit_price < high_price
    end  # items.map{|item|item.name}
  end

  def find_all_by_merchant_id(merchant_id)
    item_name = @items.find_all do |item|
      item.merchant_id == merchant_id.to_s
    end
  end

  def find_merchant_by_id(merchant_id)
    @sales_engine.find_merchant_by_id(merchant_id)
  end

  def inspect
      "#<#{self.class} #{@items.size} rows>"
  end

end
