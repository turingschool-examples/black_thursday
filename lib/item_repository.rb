require 'pry'
require 'csv'
require_relative 'item'

# This is an item repository class
class ItemRepository
  attr_reader :item_list, :parent, :items

  def initialize(item_csv, parent)
    @parent = parent
    @items = []

    csv_file = CSV.open(item_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id.to_i }
  end

  def find_by_name(name)
    # @items.find { |item| name.casecmp(item.name) } #can't get this to work
    @items.find { |item| name.downcase == item.name.downcase }
  end

  def find_all_with_description(string)
    @items.find_all { |item| item.description.include?(string) }
  end

#   all - returns an array of all known Item instances
# find_by_id - returns either nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
end
