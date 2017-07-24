require 'csv'

class ItemRepository


  # The ItemRepository is responsible for holding and searching our Item instances. This object represents one line of data from the file items.csv.
  #
  # It offers the following methods:
  #
  # all - returns an array of all known Item instances
  # find_by_id - returns either nil or an instance of Item with a matching ID
  # find_by_name - returns either nil or an instance of Item having done a case insensitive search
  # find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  # find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
  # find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  # find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied

end
