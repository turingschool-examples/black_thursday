require_relative '../lib/item'
class ItemRepository

  def initialize
    @items = []
  end

  def create(attributes)
    new_item = Item.new({id: attributes[:id], name: attributes[:name],
                                  description: attributes[:description],
                                  unit_price: attributes[:unit_price],
                                  created_at: attributes[:created_at],
                                  updated_at: attributes[:updated_at],
                                  merchant_id: attributes[:merchant_id]})
    @items << new_item
    return new_item
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.each do |item|
      if item.id == id
        return item
        break
      else
        return nil
      end
    end
  end

  def find_by_name(name)
    @items.each do |item|
      if item.name == name
        return item
        break
      else
        return nil
      end
    end
  end

  def find_all_with_description(description)
    matching_descriptions = []
    @items.each do |item|
      if item.description.include?(description)
        matching_descriptions << item
      end
    end
    return matching_descriptions
  end

  def find_all_with_price(price)
    matching_prices = []
    @items.each do |item|
      if item.price == price
        matching_prices << item
      end
    end
    return matching_prices
  end

  def find_all_by_price_in_range(range)
    valid_prices = []
    @items.each do |item|
      if range.include?(item.price)
        matching_prices << item
      end
    end
    return valid_prices
  end

  def find_all_by_merchant_id(merchant_id)
    matching_merchants = []
    @items.each do |item|
      if item.merchant_id = merchant_id
      matching_merchants << item
      end
    end
    return matching_merchants
  end

  def update(id, attributes)
    updated_item = find_by_id(id)
    updated_item.name = attributes[:name]
    updated_item.description = attributes[:description]
    updated_item.unit_price = attributes[:unit_price]
    updated_item.updated_time = Time.now
  end

  def delete(id)
    deleted_item = find_by_id(id)
    @items.delete(deleted_item)
  end
end
