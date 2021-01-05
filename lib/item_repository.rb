class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item[:id].to_i == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item[:name] == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item[:description].downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item[:unit_price].to_i == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item[:unit_price].to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item[:merchant_id].to_i == merchant_id
    end
  end

  def max_item_id
    @items.max_by do |item|
      item[:id]
    end
  end

  def create(attributes)
    attrributes[:id] = max_item_id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
  end

  def update(id, attributes)
    attributes.each do |key, value|
      if key == :name || key == :description || key == :unit_price
        find_by_id(id)[key] = attributes[key]
      end
    end
    find_by_id(id)[:udated_at] = Time.now.to_s
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

end
