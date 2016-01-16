require          'csv'
require          'pry'
require_relative 'item'

class ItemRepository
  attr_reader   :all, :items

  def initialize(csv_hash, engine = nil)
    @items = csv_hash.map {|csv_hash| Item.new(csv_hash, engine)}
  end

  def all
    items
  end

  def standard(standardized_data)
    standardized_data.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(item_id)
    items.find { |item| item.id == item_id.to_i}
  end

  def find_by_name(item_name)
    #added the to_s to not have the nil class error when downcasing
    #iterated item names
    items.find { |item| item.name.to_s.downcase == item_name.downcase}
  end

  def find_all_with_description(description)
    #finds full/fragment item descriptions
    #notice the method name for this class and the method
    #being used below to find stuff... "find_all"
    items.find_all { |item| item.description.downcase.include?(description.downcase)}
  end

  def find_all_by_price(input_price)
    items.find_all { |item| item.unit_price_to_dollars == input_price.to_f }
  end

  def find_all_by_price_in_range(range_input)
    range = (range_input).to_a
    items.find_all {|item| range_input.include?(item.unit_price_to_dollars)}
  end

  def find_all_by_merchant_id(merchant_id)
    #gives us every single item that the merchant has in his online Etsy shop
    items.find_all { |item| item.merchant_id == merchant_id.to_i}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
