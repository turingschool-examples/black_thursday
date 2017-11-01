class ItemRepository
  attr_reader :items

  def initialize(items, parent = nil)
    @items  = load_csv(items).map { |row| Item.new(row, self) }
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @items
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name.to_s.downcase == name.to_s.downcase}
  end

  def find_all_with_description(description)
    return [] if description.nil?
    items.find_all do |item|
      item.description.to_s.downcase.index(description.downcase)
    end
  end

  def find_all_by_price(price)
    return [] if price.nil?
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    return [] if range.nil?
    items.find_all do |item|
      range.cover?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    return [] if merchant_id.nil?
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_merchant_for_item(item)
    #keep consistent
    @parent.merchants.find_by_id(item.merchant_id)
  end

  def inspect
    "#{self.class} has #{all.count} rows"
  end
end
