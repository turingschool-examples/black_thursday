class ItemRepository
  attr_reader :all
  def initialize
    @all = []
  end
end


# The repository of item instances


# find_by_id(id) - returns either nil or an instance of Item

# find_by_name(name) 

# find_all_with_description(description)

# find_all_by_price(price)

# find_all_by_price_in_range(range)

# find_all_by_merchant_id(merchant_id)

# create(attributes)

# update(id, attributes)

# delete(id)