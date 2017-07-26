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
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches

# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)

# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied


end
