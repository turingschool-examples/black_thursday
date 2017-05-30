class ItemRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id
    nil
    #will take arguement of item_id
  end

  def find_by_name
    nil
    #will take argument of item_name
  end

  def find_all_with_descriptions
    []
  end

  def find_all_by_price
    []
  end

  def find_all_by_price_in_range
    []
    #will take argument of price with range and return those in that range.
  end

  def find_all_by_merchant_id
    []
  end

end
