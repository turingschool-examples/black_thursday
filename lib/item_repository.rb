require './item'
require 'CSV'

class ItemRepository
  attr_reader :all,
              :path

  def initialize(path)
    @all = create_items(path)
    @path = path
  end

  def create_items(path)
    items = CSV.read(path, headers: true, header_converters: :symbol)
    items.map do |item_data|
      Item.new(item_data)
    end
  end

  def find_by_id(id)
    return nil unless
    @all.find_all do |item|
      if item.id == id
        return item
      end
    end
  end

  def find_by_name(name)
    return nil unless
    @all.find_all do |item|
      if item.name.downcase == name.downcase
        return item
      end
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      if item.description.downcase.include?(description.downcase)
        return item
      end
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      if item.unit_price == price
        return item
      end
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    highest_id = @all.max_by do |item|
      item.id
    end
    new_item = Item.new(attributes)
    new_item.new_id(highest_id.id + 1)
    @all << new_item
    CSV.open(@path, 'ab') do |csv|
      csv << [new_item.id, new_item.name, new_item.description, new_item.unit_price, new_item.merchant_id, new_item.created_at, new_item.updated_at]
    end
  end
end
