require './lib/items'

class ItemRepository
  attr_reader  :all

  def initialize(item_data, parent)
    @parent = parent
    @all    = item_data.map { |line| Item.new(line).item }
  end

  def find_by_id(id)
    @all.find { |item| item["id"].eql?(id) }
  end 

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |item| item["merchant_id"].eql?(merchant_id) }
  end

  def find_all_with_description(fragment)
    @all.find_all do |item|
      item["description"].downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      price_range.include?(item["unit_price"].to_i)
    end
  end

  def find_all_by_price(price)
    @all.find_all { |item| item["unit_price"].eql?(price) }
  end

  def find_by_name(name)
    @all.find do |item|
      item["name"].downcase.eql?(name.downcase)
    end
  end

  def find_all_by_name(fragment)
    @all.find_all do |item|
      item["name"].downcase.include?(fragment.downcase)
    end
  end

end
