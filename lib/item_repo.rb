class ItemRepo
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item[:id] == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item[:name].downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item[:description].downcase == description.downcase
    end
  end
  
  def find_all_by_price(price) #find out more about if bigdecimal or not
    @items.find_all do |item|
      item[:unit_price].to_i == price 
    end 
  end 
  
  def find_all_by_price_in_range(range)
      @items.find_all do |item|
        item[:unit_price].to_i >= range[0] && item[:unit_price].to_i <= range[1]
      end
  end 
  
  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item[:merchant_id].to_i == merchant_id 
    end 
  end
  
  def create(attributes)
    item_new = Item.new(attributes)
    
    max_item_id = @items.max_by do |item|
      item[:id]
    end
    new_max_id = max_item_id[:id] + 1
    item_new.id = new_max_id
    @items << item_new
    return item_new
  end
  
  def update(id, attributes)
    item_to_change = find_by_id(id)
    item_to_change[:name] = attributes[:name]
    item_to_change[:description] = attributes[:description]
    item_to_change[:unit_price] = attributes[:unit_price].to_s
    item_to_change
  end
  
  def delete(id)
    item_to_delete = find_by_id(id)
    @items.delete(item_to_delete)
  end

end
