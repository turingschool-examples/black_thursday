require 'bigdecimal'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @items.find do |item|
        item.id == id
      end
    end
  end

  def a_valid_id?(id)
    @items.any? do |item| item.id == id
    end
  end

  def find_by_name(name)
    @items.find{|item| item.name.downcase == name.downcase}
  end

  def find_all_by_name(string)
    @items.find_all do |item|
      item.name.downcase.include?(string.downcase)
    end
  end
  
  def create(attribute)
    new_id = @items.last.id + 1
    @items << Item.new({:id => new_id, :name => attribute})
  end
  
  def find_all_with_description(string)
    @items.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price.to_f
    end
  end
  
  def find_all_by_price_in_range(low, high)
    @items.find_all do |item|
      item.unit_price >= low.to_f && item.unit_price <= high.to_f
    end
  end
  
  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id.to_i
    end
  end

  def create(attributes)
    new_id = @items.last.id + 1
    attributes[:id] = new_id
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    require 'pry'; binding.pry
    self.find_by_id(id)
    item[attribute.key] = [attribute.value]

      #   item_new_name = item.name.replace(name)
      #   return item_new_name
      # end
  end
  
  def delete(id)
    @items.delete(find_by_id(id))
  end
end