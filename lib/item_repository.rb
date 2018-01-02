require './lib/item'

class ItemRepository
  def initialize(file_path)
    @items = []
    item_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(item_data)
  end

  def parse(item_data)
    item_data.each do |row|
      @items << Item.new(row.to_hash)
    end
  end

  def all
    return @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description == description
    end
  end

  def find_by_price(price)
    @items.find do |item|
      item.price == price
    end
  end

  def find_by_all_by_price_in_range(price_range)
    @items.find do |item|
      price_range.cover?(item.price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
