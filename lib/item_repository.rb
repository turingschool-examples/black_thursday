require 'pry'
require 'csv'
require 'set'
require_relative 'items'

class ItemRepository

  def initialize(items)
    parse_items(items)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_items(items)
    @items_array = []
    items.each do |row|
      id          = row[:id]
      name        = row[:name]
      description = row[:description]
      unit_price  = row[:unit_price]
      created_at  = row[:created_at]
      updated_at  = row[:updated_at]
      merchant_id = row[:merchant_id]

      @items_array << Items.new({:id          => id,
                                 :name        => name,
                                 :description => description,
                                 :unit_price  => unit_price,
                                 :created_at  => created_at,
                                 :updated_at  => updated_at,
                                 :merchant_id => merchant_id})
    end
  end

  def all
    @items_array
  end

  def find_all_with_description(fragment)
    fragment = fragment.downcase
    @items_array.select do |item|
      if item.description.downcase.include?(fragment)
        item
      end
    end
  end

  def find_all_by_price(price)
    # binding.pry
    @items_array.select do |item|
      if item.unit_price == price
        item
      end
    end
  end

  def find_all_by_price_in_range(range)
    @items_array.select do |item|
      if (range).member?(item.unit_price)
        item
      end
    end
  end

  def find_by_name(item_name)
    if name_object = @items_array.find { |n| n.name.downcase == item_name.downcase}
      name_object
    else
      nil
    end
  end

  def find_by_id(item_id)
    if id_object = @items_array.find { |i| i.id == item_id}
      id_object
    else
      nil
    end
  end

  def find_all_by_merchant_id(id)
    if merchant = @items_array.select { |item| item.merchant_id == id }
      merchant
    else
      nil
    end
  end

end

if __FILE__ == $0

end
