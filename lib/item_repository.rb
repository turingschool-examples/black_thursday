require_relative '../lib/item'
require 'bigdecimal'
require 'time'


class ItemRepository

  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end


  def find_by_id(number)
    @items.find do |item|
      item.id == number
    end
  end

  def find_by_name(search_name)
    @items.find do |item|
      item.name == search_name
    end
  end

  def find_all_with_description(search_description)
    @items.find_all do |item|
      item.description.downcase.include?(search_description.downcase)
    end
  end

  def find_all_by_price(search_price)
  # Returns either [] or instances of Item where the supplied
  # price exactly matches
    @items.find_all do |item|
      item.unit_price_to_dollars == search_price
    end
  end

  def find_all_by_price_in_range(range)
   # Returns either [] or instances of Item where the supplied price is in
   # the supplied range (a single Ruby range instance is passed in)
   @items.find_all do |item|
     item.unit_price.between?(range.first, range.last)
   end
  end

  def find_all_by_merchant_id(merchant_id)
    # Returns either [] or instances of Item where the supplied
    # merchant ID matches that supplied
  end

  def create(attributes)
    # Attributes is in the form of CSV object. Create extracts the data from
    # that object and creates a new item object.
    item = Item.new({
      id: attributes[:id],
      name: attributes[:name],
      description: attributes[:description],
      #TODO What are the args for BigDecimal?
      unit_price: BigDecimal.new(attributes[:unit_price],4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: attributes[:merchant_id],
      })
      @items << item
  end

  def update(id, attributes)
    # Ppdate the Item instance with the corresponding id with the
    # provided attributes.
    # Only the item’s name, desription, and unit_price attributes
    # can be updated.
    # This method will also change the items updated_at
    # attribute to the current time.
  end

  def delete(id)
    # Delete the Item instance with the corresponding id
  end
end
