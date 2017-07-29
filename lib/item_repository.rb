
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
    results = Array.new
    @items.each do |item|
      if item.description.downcase.include?(descrip.downcase)
        results << item
      end
    end
    results
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == BigDecimal.new(price)
    end
  end

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
    # binding.pry
    results = @items.find_all do |item|
      # binding.pry
      range.include?((item.unit_price))  #.to_f * 100).to_i)
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
    "#<#{self.class} #{@items.size} rows>"
  end

end
