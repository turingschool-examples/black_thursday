require 'csv'

class ItemRepository

  attr_reader :item_repo

  def initialize(item_repo)
    @item_repo = item_repo
  end

  # The ItemRepository is responsible for holding and searching our Item instances. This object represents one line of data from the file items.csv.

  def all
    # returns an array of all known Item instances
  end

  def find_by_id
    # returns either nil or an instance of Item with a matching ID
  end

  def find_by_name
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def find_all_with_description
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def find_all_by_price
    # returns either [] or instances of Item where the supplied price exactly matches
  end

  def find_all_by_price_in_range
    # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def find_all_by_merchant_id
    # returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end

end
