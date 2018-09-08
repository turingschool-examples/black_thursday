class ItemRepository
  def all
    # Returns an array of all known Item instances
  end


  def find_by_id(id)
    # Returns either nil or an instance of Item with a matching ID
  end

  def find_by_name(name)
    # Returns either nil or an instance of Item having
    # done a case insensitive search
  end

  def find_all_with_description(description)
    #returns either [] or instances of Item where the supplied string appears
    # in the item description (case insensitive)
  end

  def find_all_by_price(price)
  # Returns either [] or instances of Item where the supplied
  # price exactly matches
  end

  def find_all_by_price_in_range(range)
   # Returns either [] or instances of Item where the supplied price is in
   # the supplied range (a single Ruby range instance is passed in)
  end

  def find_all_by_merchant_id(merchant_id)
    # Returns either [] or instances of Item where the supplied
    # merchant ID matches that supplied
  end

  def create(attributes)
    # Create a new Item instance with the provided attributes.
    # The new Item’s id should be the current highest Item id plus 1.
  end

  def update(id, attributes)
    # Ppdate the Item instance with the corresponding id with the
    # provided attributes.
    # Only the item’s name, desription, and unit_price attributes
    # can be updated.
    # This method will also change the items updated_at
    # attribute to the current time.
  end

  def delete(id)
    # Delete the Item instance with the corresponding id
  end
end
