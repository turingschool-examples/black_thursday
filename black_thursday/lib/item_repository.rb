class ItemRepository
  attr_reader :items,
              :parent

  def initialize(csv_filename, parent)
    # @items  =  load_csv(csv_filename).map { |row| Item.new(row, self) }
    @items  = []
    @parent = parent
    @load   = load_things(csv_filename)
  end

  def load_things(filename)
    CSV.foreach(filename) do |row|
      @items << Item.new(row)
    end
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
      item.description.to_s.downcase.include?(description.downcase)
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
      #this still works with item.unit_price! probs need to add a test
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
    @parent.merchants.find_by_id(item.merchant_id)
  end

  def inspect
    "#{self.class} has #{all.count} rows"
  end

  private

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

end
