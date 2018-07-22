require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  def from_csv(hash)
    @items_csv = CSV.open(hash[:items], headers: true, header_converters: :symbol)
    @merchants_csv = CSV.open(hash[:merchants], headers: true, header_converters: :symbol)
  end

  def items
    #returns an instance of ItemRepository with all the item instances loaded
    @items_csv

  end

  def merchants

  end

end
