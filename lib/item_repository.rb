# Basic ItemRepository class

class ItemRepository
  attr_reader :csv_array

  def initialize(csv_array)
    @csv_array = csv_array
  end

  def all
    @csv_array
  end

  def find_by_id(id)
    @csv_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @item_array.find do |item|
      item.name.casecmp == name.casecmp
    end
  end

  def find_all_with_description(string)
    @csv_array.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(amount)
    @csv_array.find_all do |item|
      item.unit_price == amount
    end
  end

  def find_all_by_price_in_range(range)
    @csv_array.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @csv_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def max_id_number_new
    old_max = @csv_array.max_by do |item|
      item.id
    end.id
    (old_max.to_i + 1).to_s
  end

  def create(item_hash)
    attributes = {
      id: max_id_number_new,
      name: item_hash[:name],
      description: item_hash[:description],
      unit_price: item_hash[:unit_price],
      created_at: Time.now.to_s,
      updated_at: Time.new.to_s,
      merchant_id: item_hash[:merchant_id]
    }
    Item.new(attributes)
  end

  def update(id, attributes)
    update_instance = find_by_id(id)
    if attributes[:name] != nil
      update_instance.name = attributes[:name]
    elsif attributes[:description] != nil
      update_instance.description = attributes[:description]
    elsif attributes[:unit_price] != nil
      update_instance.unit_price = attributes[:unit_price]
    end
  end
end
