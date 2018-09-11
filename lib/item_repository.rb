require_relative '../lib/item'
require 'bigdecimal'
require 'time'


class ItemRepository

  attr_reader :items

  def initialize
    @items = []
  end

  def inspect
  "#<\#{self.class} \#{@items.size} rows>"
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
     item.unit_price.to_f.between?(range.first, range.last)
   end
  end

  def find_all_by_merchant_id(search_merchant_id)
    # Returns either [] or instances of Item where the supplied
    # merchant ID matches that supplied
    @items.find_all do |item|
      item.merchant_id == search_merchant_id
    end
  end

  def create(attributes)

    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id: attributes[:id],
        name: attributes[:name],
        description: attributes[:description],
        #TODO This line is very ugly
        unit_price: BigDecimal.new(attributes[:unit_price].to_f/100, attributes[:unit_price].length),
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
        merchant_id: attributes[:merchant_id]
        }
      item = Item.new(hash)
      @items << item

    else
      #Gererated on the fly
      hash = {
        id: find_next_id,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        updated_at: attributes[:updated_at],
        created_at: attributes[:created_at]
      }
      item = Item.new(hash)
      @items << item

    end
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      find_by_id(id).name = attributes[:name] if attributes[:name] != nil
      find_by_id(id).description = attributes[:description] if attributes[:description] != nil
      find_by_id(id).unit_price = attributes[:unit_price] if attributes[:unit_price] != nil
      find_by_id(id).updated_at = Time.now
    end
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def find_next_id
    max_id = @items.max_by do |item|
      item.id
    end.id
    max_id += 1
  end
end
