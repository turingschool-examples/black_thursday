class ItemRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers:true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |item|
      item.id.to_i == id.to_i
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(desc_fragment)
    all.find_all do |item|
      item.description.downcase.include?(desc_fragment.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    all.find_all do |item|
      price = item.unit_price_to_dollars
      price_range.member?(price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id == merchant_id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
