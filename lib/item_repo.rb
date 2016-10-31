require 'csv'

module ItemRepo
  def set_up(file)
    file = CSV.open "items.csv", headers: true, header_converters: :symbol
  end

  def all
    #returns array of all items
  end

  def find_by_id
    #search by id number
    #returns object matching id number
  end

  def find_by_name
    #search for a name
    #return item with that name, case insensitive
  end

  def find_all_with_description
    #returns instances of item where the supplied string occurs in the description
    #case insensitive
  end

  def find_all_by_price
    #returns objects that match with price provided
  end

  def find_all_by_price_in_range
      #returns objects that match with range price provided
  end

  def find_all_by_merchant_id
    #search merchant with that id
    #returns all items of that merchant
  end
end
