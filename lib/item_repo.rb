require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :items, :grouped_by_merchant_id

  def initialize(raw)
    @items                  = load_data
    @grouped_by_merchant_id = items.group_by(:merchant_id)
  end

  # The ItemRepository is responsible for holding and searching our Item instances. This object represents one line of data from the file items.csv.

  def all
    items
  end

  def find_by_id(id)
    items.detect { |item| item.id == id }
    # returns either nil or an instance of Item with a matching ID
  end

  def find_by_name(name)
    items.detect { |item| item.name.downcase == name.downcase }
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_with_description(description)
    items.select { |item| item.description.downcase == description.downcase }
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def find_all_by_price(price)
    items.select { |item| item.unit_price == price }
    # returns either [] or instances of Item where the supplied price exactly matches
  end

  def find_all_by_price_in_range(range)
    items.select { |item| range.include?(item.unit_price) }
    # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end


  def find_all_by_merchant_id(merchant_id)
    grouped_by_merchant_id[merchant_id] || []
  end

end
