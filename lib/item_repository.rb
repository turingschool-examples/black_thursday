# Basic ItemRepository class

class ItemRepository
  attr_reader :item_array

  def initialize(item_array)
    @item_array = item_array
  end

  def all
    @item_array
  end

  def find_by_id(id)
    @item_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @item_array.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(string)
    @item_array.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(amount)
    @item_array.find_all do |item|
      item.unit_price == amount
    end
  end

  def find_all_by_price_in_range(range)
    @item_array.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @item_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def max_id_number_new
    old_max = @item_array.max_by do |item|
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
end
