require 'csv'
require "bigdecimal"
require_relative './sales_engine'

class ItemRepository
  attr_reader :items

  def initialize(data)
    @items = data
    # require "pry"; binding.pry
  end

  def all
    @items
  end

  def find_by_id(id)
    item_id = nil
    @items.select do |item|
      if item.id == id
        item_id = item
      end
    end
    item_id
  end

  def find_by_name(name)
    item_name = nil
    @items.select do |item|
      if item.name == name
        item_name = item
      end
    end
    item_name
  end

  def find_all_with_description(description)
    items_with_description = []
    @items.each do |item|
      if item.description.downcase.include?(description.downcase)
        items_with_description << item
      end
    end
    items_with_description
  end

  def find_all_by_price(price)
   @items.find_all do |item|
       #BigDecimal(item.unit_price) == BigDecimal(price)
       if item.unit_price == price
         item
     end
    end
  end

  def find_all_by_price_in_range(range)
    ranges = []
    ranges << range.first
    ranges << range.last
    items_with_price_in_range = @items.find_all do |item|
      if item.unit_price.between?(ranges[0],ranges[1])
        item
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      if item.merchant_id == merchant_id
        item
      end
    end
  end

  def highest_id
    new = @items.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
   new_item = Items.new({id: highest_id,
                        name: attributes[:name],
                        description: attributes[:description],
                        unit_price: attributes[:unit_price],
                        updated_at: attributes[:updated_at],
                        created_at: attributes[:created_at],
                        merchant_id: attributes[:merchant_id]})
    @items << new_item
  end

  def update(id, attributes)
    # update = find_by_id(id)
    # update = {name: attributes[:name],
    #                   description: attributes[:description],
    #                   unit_price: attributes[:unit_price],
    #                   updated_at: Time.now.strftime('%Y-%m-%d')}
    # # update the item instance with id and provided attributes
    # # items name description and unitprice can be updated
    # # updated_at = time.now?
  end

  def delete(id)
    trash = @items.find do |item|
      item.id == id
    end
    items.delete(trash)
  end

end
