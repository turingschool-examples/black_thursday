require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader   :contents,
                :items

  def initialize(path)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @items = contents.map do |line|
      binding.pry
      Item.new(line)
    end
  end

  #returns an array of all known Item instances
  def all
    @items
  end

  #returns either nil or an instance of Item with a matching ID
  def find_by_id
  end

  #returns either nil or an instance of Item having done a case insensitive search
  def find_by_name
  end

  #returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  def find_all_with_description
  end

  #returns either [] or instances of Item where the supplied price exactly matches
  def find_all_by_price
  end

  #returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  def find_all_by_price_in_range
  end

  #returns either [] or instances of Item where the supplied merchant ID matches that supplied
  def find_all_by_merchant_id
  end

end

repository = ItemRepository.new('fixture/items.csv')
