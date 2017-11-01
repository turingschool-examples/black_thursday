require './lib/item'

class ItemRepository
  attr_reader :items,
              :find_all_by_description,
              :find_all_by_price_in_range

  def initialize(parent)
    @items = []
    @sales_engine = parent
  end

  def create_item(data)
    my_reference = self
     CSV.foreach  data[:items], headers: true, header_converters: :symbol do |row|
      @items << Item.new(row, my_reference)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find{|item| item.id == id}
  end

  def find_by_name(name)
   @items.find{|item| name if item.name == name}
  end

  def find_all_by_description(description)
   @items.find_all{|item| item.description == description}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(low_price, high_price)
    items = @items.find_all do |item|
       item.unit_price.to_i < high_price.to_i && item.unit_price.to_i > low_price.to_i
    end
    items.map{|item|item.name}
  end

  def find_all_by_merchant_id(merchant_id)
     @items.find_all{|item| item.merchant_id == merchant_id}
  end

end
