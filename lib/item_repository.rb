require './lib/item'

class ItemRepository

  def initialize(inventory_array)
    @inventory = inventory_array
  end

  def all
    @inventory.empty? ?  nil : @inventory.to_a
  end

  def find_by_id(find_id)
    @inventory.find {|item| item.id == find_id }
  end

  def find_by_name(find_name)
    @inventory.find {|item| item.name.downcase == find_name.downcase }
  end

  def find_all_with_description(find_description)
    @inventory.find_all {|item| item.description.downcase == find_description.downcase }
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
