require 'csv'
require_relative './item'

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

  def find_by_id

  # returns either nil or an instance of Item with a matching ID
  end

  def find_all_by_name
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_with_description
    #returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def find_all_by_price

    # returns either [] or instances of Item where the supplied price exactly matches

  end

  def find_all_by_price_in_range
    #returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def find_all_by_merchant_id

    #returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end


end
