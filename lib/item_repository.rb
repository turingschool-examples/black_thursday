require_relative './data_repository'
require_relative './item'

class ItemRepository < DataRepository
  def initialize(data)
    populate(data, Item)
  end

  def items
    return @data_set.values
  end

  # returns either [] or instances of Item where the supplied string appears in
  # the item description (case insensitive)
  def find_all_with_description(description)
  end

  # returns either [] or instances of Item where the supplied price exactly
  # matches
  def find_all_by_price(price)
  end

  # returns either [] or instances of Item where the supplied price is in the
  # supplied range (a single Ruby range instance is passed in)
  def find_all_by_price_in_range(range)
  end

  # returns either [] or instances of Item where the supplied merchant ID
  # matches that supplied
  def find_all_by_merchant_id(merchant_id)
  end
end
