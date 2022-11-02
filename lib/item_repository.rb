class ItemRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_to_repo(item)
    @all << item
  end
  
  def find_by_id(id)
    @all.find do |item|
      item.id == id      
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_with_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end

 

# find_all_with_description(description)

# find_all_by_price(price)

# find_all_by_price_in_range(range)

# find_all_by_merchant_id(merchant_id)

# create(attributes)

# update(id, attributes)

# delete(id)