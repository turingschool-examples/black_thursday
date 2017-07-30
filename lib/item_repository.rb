
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
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name == name}
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

  # def find_all_with_decription(descript)
  #   @items.find_all {|item| item.description.downcase.include?(descript.downcase)}
  # end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == BigDecimal.new(price)
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?((item.unit_price))
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all {|item| item.merchant_id == id}
  end

  def add_data(data)
    @items << Item.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
