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

  # can we use find_all_with_price?
  def find_all_with_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  # helper method for create method
  def max_id 
    max = @all.max_by do |item|
      item.id
    end
    return 1 if max.nil?
    new_max = max.id + 1
  end

  def create(item)
    item[:id] = max_id
    add_to_repo(Item.new(item))
  end

  def update(id, attributes)
    item = find_by_id(id)
    # working here
    attributes.keys.each do |key|
      item.name = attributes[:name]
    end
  end


end

# update(id, attributes)

# delete(id)