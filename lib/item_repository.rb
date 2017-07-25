require 'simplecov'
SimpleCov.start

class ItemRepository

  attr_reader :items

  def initialize(filepath)
    @items = []
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol, converters: :numeric) do |row|
      @items << Item.new(row.to_h)
    end
  end


#all - returns an array of all known Item instances

#find_by_id - returns either nil or an instance of Item with a matching ID

# find_by_name - returns either nil or an instance of Item having done a case insensitive search

# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)

# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches

# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)

# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied


end
