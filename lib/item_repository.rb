require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader   :contents,
                :items

  def initialize(path)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @items = contents.map do |line|
      Item.new(line)
    end
  end

  #returns an array of all known Item instances
  def all
    @items
  end

  def find_by_id(id_number)
    value = nil
    items.each do |item|
      value = item if item.id == id_number
    end
    value
  end

  def find_by_name(name)
    value = nil
    items.each do |item|
      value = item if item.name.downcase == name.downcase
    end 
    value
  end

  #returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  def find_all_with_description
  end

  def find_all_by_price(price)
    value = []
    items.each do |item|
    value << item if item.unit_price == price
    end
    value
  end

  #returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  def find_all_by_price_in_range
  end

  #returns either [] or instances of Item where the supplied merchant ID matches that supplied
  def find_all_by_merchant_id
  end

end

repository = ItemRepository.new('fixture/items.csv')
