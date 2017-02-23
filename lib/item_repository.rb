require 'csv'
require_relative './item'
require 'pry'

class ItemRepository
  attr_accessor :items

  def initialize(path)
    @items = Hash.new
    populate_repository(path)
  end

  def populate_repository(path)
    data = CSV.read(path, headers: true, header_converters: :symbol)
      data.each do |item|
        items[item[:id].to_sym] = Item.new(item)
      end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    all_items = []
    items.each do |id, item|
      all_items << item
    end
    all_items
    # returns an array of all known Item instances
  end

  def find_by_id(id)
    items[id.to_s.to_sym]
  # returns either nil or an instance of Item with a matching ID
  end

  def find_by_name(name_to_search_for)
    items.each do |id, item|
      return item if item.name.downcase == name_to_search_for.downcase
    end
    nil
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_with_description(description_fragment)
    items_matching_description = []
    items.each do |id, item|
      items_matching_description << item if item.description.downcase.include?(description_fragment.downcase)
    end
    items_matching_description
    #returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def find_all_by_price(price)
    items_matching_price = []
    items.each do |id, item|
      items_matching_price << item if item.unit_price == price
    end
    items_matching_price
    # returns either [] or instances of Item where the supplied price exactly matches

  end

  def find_all_by_price_in_range(range)
    range_minimum = range.first
    range_maximum = range.last
    items_matching_supplied_range = []
    items.each do |id, item|
      items_matching_supplied_range << item if item.unit_price >= range_minimum && item.unit_price <= range_maximum

    end
    items_matching_supplied_range
    #returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def find_all_by_merchant_id(merchant_id)
    items_matching_merchant_id = []
    items.each do |id, item|
      items_matching_merchant_id << item if item.merchant_id == merchant_id
    end
    items_matching_merchant_id
    #returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end


end
