require "pry"

class ItemRepository
  attr_reader :file_path, :items
  def initialize(file_path)
    @file_path = file_path
    @items = all
  end

  def all
    items = CSV.read(@file_path, headers: true, header_converters: :symbol)
    items_instances_array = []
    items.by_row!.each do |row|
      items_instances_array << Item.new(row)
    end
    items_instances_array
  end

  def find_by_id(id)
    items.find do |item_instance|
    item_instance.item_attributes[:id] == id
    end
  end

  def find_by_name(name)
    items.find do |item_instance|
    item_instance.item_attributes[:name].downcase == name.downcase
    end
  end

  def find_all_with_description(string)
    items.find_all do |item_instance|
      item_instance.item_attributes[:description].include?(string)
      end
  end

  def find_all_by_price(integer)
    items.find_all do |item_instance|
    item_instance.item_attributes[:unit_price] == integer.to_s
    end
  end

  def find_all_by_price_in_range(range)
    range_items_to_check = []
    items.each do |item_instance|
        range_items_to_check << (item_instance.item_attributes[:unit_price].to_f <= range.to_a.max && item_instance.item_attributes[:unit_price].to_f >= range.to_a.min)
    end
    return range_items_to_check
  end

  def find_all_by_merchant_id(input_id)
    items.find_all do |item_instance|
      item_instance.item_attributes[:merchant_id].equal?(input_id)
      end
  end

  def create(attributes)
    attributes[:id] = @items[-1].item_attributes[:id] + 1
    keys = [:name, :id, :description, :unit_price, :merchant_id]
    keys.each do |key|
      if !attributes[key]
        attributes[key] = ""
      end
    end
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    items << Item.new(attributes)
  end

  def update(id, attributes)
    if !(attributes.include?(:id) || attributes.include?(:merchant_id) || attributes.include?(:created_at) || attributes.include?(:updated_at))
      find_by_id(id).item_attributes[:name] = attributes[:name]
      find_by_id(id).item_attributes[:description] = attributes[:description]
      find_by_id(id).item_attributes[:unit_price] = attributes[:unit_price]
    end
    find_by_id(id).item_attributes[:updated_at] = Time.now
  end

  def delete(id)
    items.delete(find_by_id(id))
  end

end
