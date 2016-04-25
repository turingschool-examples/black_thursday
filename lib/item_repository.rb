require_relative 'item'

class ItemRepository

  attr_reader :items

  def initialize(items_data)
    @items = create_items(items_data)
  end

   def create_items(items_data)
     items_data.map do |item|
       Item.new(item)
     end
   end

  def all
    @items
  end

  def find_by_id(item_id)
    items.find do |item|
      item.id == item_id
    end
  end

  def find_by_name(item_name)
    items.find do |item|
      item.name == item_name
    end
  end

  def find_all_with_description(string_description)
    items.find_all do |item|
      item.description.downcase.include?(string_description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
