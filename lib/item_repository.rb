
require_relative '../lib/item'
class ItemRepository
  attr_reader :items
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = []
  end


  def all
    @items
  end

  def find_by_id(id)
    result = nil
    @items.each do |item|
      if item.id == id
        result = item
      end
    end
    result
  end

  def find_by_name(name)
    result = nil
    @items.each do |item|
      if item.name == name
        result = item
      end
    end
    result
  end

  def find_all_with_description(descrip)
    results = []
    @items.each do |item|
      if item.description.downcase.include?(descrip.downcase)
        results << item
      end
    end
    results
  end

  def find_all_by_price(price)
    results =  []
    @items.each do |item|
      if item.unit_price == price
        results << item
      end
    end
    results
  end

  [1..10]

  # def find_all_by_price_in_range(price_low, price_high)
  #   results = []
  #   @items.each do |item|
  #     if item.unit_price >= price_low && item.unit_price <= price_high
  #       results << item
  #     end
  #   end
  #   results
  # end

  def find_all_by_price_in_range(range)
    results = []
    @items.each do |item|
      if (range).member?(item.unit_price)
        results << item
      end
    end
    results
  end


  def find_all_by_merchant_id(merch_id)
    results = []
    @items.each do |item|
      if item.merchant_id == merch_id
        results << item
      end
    end
    results
  end

  def add_data(data)
    @items << Item.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
