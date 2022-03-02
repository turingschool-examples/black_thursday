require 'pry'
require 'csv'
require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  attr_reader :items
  # attr_accessor :id

  #def inspect
  #  "#<\#{self.class} \#{@items.size} rows>"
  #end

  def initialize(data)
    @items =[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @items << Item.new(row)
    end
    super(@items)
  end

  #def all
  #  @items
  #end

  # def find_by_id(id)
  #   item_found = @items.find {|item| item.id == id}
  # end
  #
  # def find_by_name(name)
  #   @items.find {|item| item.name.downcase == name.downcase}
  # end

  def find_all_with_description(description)
    @items.find_all {|item| item.description.downcase.include?(description.downcase)}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price == BigDecimal(price)}
  end

  def find_all_by_price_in_range(range)
    @items.find_all {|item| range.include?(item.unit_price)}
  end

  # def find_all_by_merchant_id(merchant_id)
  #   @items.find_all {|item| item.merchant_id == merchant_id}
  # end

  def create(attributes)
    attributes[:id] = @items.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_item = Item.new(attributes)
    @items << new_item
    new_item
  end

   def update(id, attributes)
     item_to_update = find_by_id(id)
     if item_to_update != nil
         attributes.each do |key, value|
           if ![:id, :created_at, :merchant_id].include?(key)
             item_to_update.info[key.to_sym] = value
             item_to_update.info[:updated_at] = (Time.now + 1).to_s
           end
         end
     end
     item_to_update
   end
  #
  # def delete(id)
  #   @items.delete(find_by_id(id)) if find_by_id(id) != nil
  # end
end
