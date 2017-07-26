require 'simplecov'
SimpleCov.start

class ItemRepository

  attr_reader :items

  def initialize(filepath)
    @items = []
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol, converters: :all) do |row|
      @items << Item.new(row.to_h)
    end
  end

  def all
    @items
  end

  def find_by_id(item_id, found_item = '')
    @items.each do |item|
      if item.id == item_id
        found_item = item
        break
      else
        found_item = nil
      end
    end
    found_item
  end

  def find_by_name(item_name, found_item = nil)
    @items.find do |item|
      if item.name.upcase == item_name.upcase
        found_item = item
      end
    end
    found_item
  end

  def find_all_with_description(description_fragment, found_items = [])
    @items.each do |item|
      if item.description.upcase.include?(description_fragment.upcase)
        found_items << item
      end
    end
    found_items
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @items.find_all do |item|
      item.unit_price <= price_range.max && item.unit_price >= price_range.min
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
