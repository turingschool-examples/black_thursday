require './lib/item'

class ItemRepository

  def initialize(inventory_array)
    @inventory = inventory_array
  end

  def all
    @inventory.each do |item|
      item
    end# all - returns an array of all known Item instances
  end

  def find_by_id(id)
    # find_by_id - returns either nil or an instance of Item with a matching ID
  end

  def find_by_name(name)
    # find_by_name - returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_with_description(description)
    # find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def find_all_by_price(price)
    # find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches

  end

  def find_all_by_price_in_range(range)
    # find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def find_all_by_merchant_id(merchant_id)
    # find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end

end
