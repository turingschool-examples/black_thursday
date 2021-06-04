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
  end

  def update(id, attributes)
    @all.find do |item|
      if item.id == id
        item.update_name(attributes[:name])
        item.update_description(attributes[:description])
        item.update_unit_price(attributes[:unit_price])
        item.update_updated_at
      end
    end
  end

  def delete(id, attributes)
    to_delete = @all.find do |item|
      item.id == id
    end
    @all.delete(to_delete)
  end
end
