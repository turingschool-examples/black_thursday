require_relative 'item'
require 'csv'

# all - returns an array of all known Item instances
# find_by_id - returns either nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

class ItemRepository

  attr_reader :all

  def initialize(se, item_csv)
    @all = []
    @se = se
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      @all << Item.load_csv(row)
    end
  end

  def find_by_id(id)
    all.each do |item|
      return item if item.id == id
    end
    nil
  end

  def find_by_name(name)
    all.each do |item|
      return item if item.name.downcase == name.downcase
    end
    nil
  end

  def find_all_with_description(description)
    item_array = []
    all.each do |item|
      item_array << item if item.description.include?(description.downcase)
    end
    item_array
  end

end
